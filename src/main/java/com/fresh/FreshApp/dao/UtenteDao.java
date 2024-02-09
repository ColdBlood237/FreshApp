package com.fresh.FreshApp.dao;

import java.util.List;

import javax.persistence.EntityManager;

import com.fresh.FreshApp.model.Utente;

public class UtenteDao implements InterfaceDao<Utente> {

	private EntityManager manager;

	public UtenteDao(EntityManager em) {
		manager = em;
	}

	@Override
	public Utente create(Utente ref) {
		manager.persist(ref);
		return ref;
	}

	@Override
	public List<Utente> retrieve() {
		return manager.createQuery("Select x from Utente x ", Utente.class).getResultList();
	}

	@Override
	public Utente update(Utente ref) {
		manager.persist(ref);
		return ref;
	}

	@Override
	public void delete(Utente ref) {
		manager.remove(ref);
	}

	public List<Utente> searchByUsername(String username) {
		return manager.createQuery("select x from Utente x where x.username like :parUsername", Utente.class)
				.setParameter("parUsername", "%" + username + "%").getResultList();
	}

	public List<Utente> retrieveByEmail(String email) {
		return manager.createQuery("select x from Utente x where x.email = :parEmail", Utente.class)
				.setParameter("parEmail", email).getResultList();
	}

	public List<Utente> retrieveByUsername(String username) {
		return manager.createQuery("select x from Utente x where x.username = :parUsername", Utente.class)
				.setParameter("parUsername", username).getResultList();
	}

	public List<Utente> retrieveById(Integer id) {
		return manager.createQuery("select x from Utente x where x.id = :parId", Utente.class)
				.setParameter("parId", id).getResultList();
	}

	public Boolean usernameAlreadyUsed(String username) {
		return retrieveByUsername(username).size() > 0 ? true : false;
	}

	public Boolean emailAlreadyUsed(String email) {
		return retrieveByEmail(email).size() > 0 ? true : false;
	}

}
