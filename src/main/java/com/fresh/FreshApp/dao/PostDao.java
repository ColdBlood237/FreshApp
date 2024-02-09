package com.fresh.FreshApp.dao;

import java.util.List;

import javax.persistence.EntityManager;

import com.fresh.FreshApp.model.Post;

public class PostDao implements InterfaceDao<Post> {

	private EntityManager manager;

	public PostDao(EntityManager em) {
		manager = em;
	}

	@Override
	public Post create(Post ref) {
		manager.persist(ref);
		return ref;
	}

	@Override
	public List<Post> retrieve() {
		return manager.createQuery("Select x from Post x order by dataPubblicazione desc", Post.class).getResultList();
	}

	@Override
	public Post update(Post ref) {
		manager.persist(ref);
		return ref;
	}

	@Override
	public void delete(Post ref) {
		manager.remove(ref);
	}

	public List<Post> retrieveByUsername(String username) {
		return manager
				.createQuery("Select x from Post x join Utente y where y.username = :parAutore",
						Post.class)
				.setParameter("parAutore", username).getResultList();
	}

	public List<Post> retrieveByUtente(Integer id) {
		return manager.createQuery("Select x from Post x where x.autore = :parAutore", Post.class)
				.setParameter("parAutore", id).getResultList();
	}

	public List<Post> searchByTesto(String testo) {
		return manager.createQuery("Select x from Post x where x.testo like :parTesto", Post.class)
				.setParameter("parTesto", "%" + testo + "%").getResultList();
	}

	public List<Post> retrieveById(Integer id) {
		return manager.createQuery("Select x from Post x where x.id = :parId", Post.class)
				.setParameter("parId", id).getResultList();
	}

	public List<Post> retrieveByLikesDesc() {
		return manager.createQuery(
				"select x from Post x left join x.likes y group by x order by count(y) desc",
				Post.class).getResultList();
	}

	public List<Post> retrieveByCommentsDesc() {
		return manager.createQuery(
				"select x from Post x left join x.commenti y group by x order by count(x) desc",
				Post.class).getResultList();
	}
}
