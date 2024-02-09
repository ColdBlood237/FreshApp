package com.fresh.FreshApp.dao;

import java.util.List;

import javax.persistence.EntityManager;

import com.fresh.FreshApp.model.Commento;
import com.fresh.FreshApp.model.Post;
import com.fresh.FreshApp.model.Utente;

public class CommentoDao implements InterfaceDao<Commento> {

	private EntityManager manager;

	public CommentoDao(EntityManager manager) {
		this.manager = manager;
	}

	@Override
	public Commento create(Commento ref) {
		manager.persist(ref);
		return ref;
	}

	@Override
	public List<Commento> retrieve() {
		return manager.createQuery("Select x from Commento x order by dataPubblicazione desc", Commento.class)
				.getResultList();
	}

	@Override
	public Commento update(Commento ref) {
		manager.persist(ref);
		return ref;
	}

	@Override
	public void delete(Commento ref) {
		manager.remove(ref);
	}

	public List<Commento> retrieveByPost(Post post) {
		return manager
				.createQuery("Select x from Commento x where x.post_id order by dataPubblicazione desc = :parPostId",
						Commento.class)
				.setParameter("parPostId", post.getId()).getResultList();
	}

	public List<Commento> retrieveByUtente(Utente utente) {
		return manager
				.createQuery(
						"Select x from Commento x where x.utente_id = :parUtenteId order by dataPubblicazione desc",
						Commento.class)
				.setParameter("parPostId", utente.getId()).getResultList();
	}

	public List<Commento> retrieveById(Integer id) {
		return manager.createQuery("Select x from Commento x where x.id like :parId", Commento.class)
				.setParameter("parId", id).getResultList();
	}
}
