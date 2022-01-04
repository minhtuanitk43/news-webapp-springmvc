package com.laptrinhjavaweb.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.laptrinhjavaweb.converter.CommentConverter;
import com.laptrinhjavaweb.dto.CommentDTO;
import com.laptrinhjavaweb.dto.MyUser;
import com.laptrinhjavaweb.dto.NotificationDTO;
import com.laptrinhjavaweb.entity.CommentEntity;
import com.laptrinhjavaweb.entity.NewEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.repository.CommentRepository;
import com.laptrinhjavaweb.repository.NewRepository;
import com.laptrinhjavaweb.repository.UserRepository;
import com.laptrinhjavaweb.service.ICommentService;
import com.laptrinhjavaweb.service.INotificationService;
import com.laptrinhjavaweb.util.SecurityUtils;

@Service
public class GetNotification implements INotificationService {
	@Autowired
	private ICommentService commentService;

	@Autowired
	private NewRepository newRepository;

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private CommentRepository commentRepository;

	@Autowired
	private CommentConverter commentConverter;

	public List<NotificationDTO> getNotification() {
		List<NotificationDTO> result = new ArrayList<>();		
		List<CommentDTO> listComment = new ArrayList<>();
		
		MyUser myUser = SecurityUtils.getPrincipal();
		if (myUser != null) {
			String userName = myUser.getUsername();;
			List<String> roles = SecurityUtils.getAuthorities();
			Sort sort = new Sort(Sort.Direction.DESC, "createdDate");
			Pageable pageable = new PageRequest(0, 20, sort);
			
			if (roles.contains("ADMIN") || roles.contains("EDITOR")) {
	
				listComment = commentService.findAll(pageable);
				
			} else if(roles.contains("AUTHOR")){			
								
					List<NewEntity> listNewEntity = newRepository.findAllByCreatedBy(userName);
					if (listNewEntity.size() > 0) {
						for (NewEntity newEntity : listNewEntity) {
							List<CommentEntity> cmtEntities = commentRepository.findAllByNewsId(newEntity.getId(), pageable);
							if(cmtEntities.size() > 0) {
								List<CommentDTO> cmtDtos = new ArrayList<>();
								for (CommentEntity cmtEntity : cmtEntities) {								
									Long userId = cmtEntity.getUser().getId();
									UserEntity userEntity = userRepository.findOne(userId);
									CommentDTO cmtDto = commentConverter.toDto(cmtEntity);								
									cmtDto.setUserName(userEntity.getFullName());
									cmtDtos.add(cmtDto);							
								}
								listComment.addAll(cmtDtos);
							}
						}
					}
				
			}
			if(listComment.size() > 0) {
				Collections.sort(listComment, new Comparator<CommentDTO>() {
					@Override
					public int compare(CommentDTO lhs, CommentDTO rhs) {
						return rhs.getStatus().compareTo(lhs.getStatus());
					}
				});
				for (CommentDTO cmtDto : listComment) {
					UserEntity userEntity = userRepository.findOne(cmtDto.getUserId());
					if(!userEntity.getUserName().equals(userName)) {
						NotificationDTO notDto = new NotificationDTO();
						notDto.setUserName(cmtDto.getUserName());
						notDto.setUserId(cmtDto.getId());
						notDto.setNewId(cmtDto.getNewId());
						notDto.setCommentId(cmtDto.getId());
						notDto.setCreatedDate(cmtDto.getCreatedDate());
						notDto.setStatus(cmtDto.getStatus());
						NewEntity newEntity = newRepository.getOne(cmtDto.getNewId());
						notDto.setNewTitile(newEntity.getTitle());
						result.add(notDto);
					}
				}
			}
		}
		return result;

	}
}
