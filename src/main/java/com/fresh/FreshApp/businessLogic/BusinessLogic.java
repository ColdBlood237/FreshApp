package com.fresh.FreshApp.businessLogic;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.persistence.EntityManager;

import com.fresh.FreshApp.dao.*;
import com.fresh.FreshApp.exception.*;
import com.fresh.FreshApp.model.*;

public class BusinessLogic {

	private EntityManager manager;
	private UtenteDao utenteDao;
	private PostDao postDao;
	private CommentoDao commentoDao;

	public BusinessLogic(EntityManager m, UtenteDao u, PostDao p, CommentoDao c) {
		manager = m;
		utenteDao = u;
		postDao = p;
		commentoDao = c;
	}

	/* ///////////// OPERAZIONI SU UTENTI //////////////// */
	// ok
	public Utente insertUser(String email, String username, String password, String confermaPassword,
			String dataNascita)
			throws Exception {
		try {
			manager.getTransaction().begin();
			if (email.trim().isEmpty() || username.trim().isEmpty() || username.trim().isEmpty()
					|| dataNascita.trim().isEmpty()) {
				throw new InvalidFieldsException("Tutti i campi sono obbligatori", null);
			}
			if (utenteDao.usernameAlreadyUsed(username)) {
				throw new UsernameAlreadyUsedException("Username già usata", null);
			}
			if (utenteDao.emailAlreadyUsed(email)) {
				throw new EmailAlreadyUsedException("Email già usata", null);
			}
			if (!password.equals(confermaPassword)) {
				throw new PasswordsNotMatchingException("Le passwords non sono uguali", null);
			}
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate dataNascitaDate = LocalDate.parse(dataNascita, formatter);
			Utente newUser = new Utente(email, username, password, dataNascitaDate);
			utenteDao.create(newUser);
			manager.getTransaction().commit();
			return newUser;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public Utente insertUser(String email, String username, String password, String confermaPassword,
			String dataNascita, String immagineProfilo)
			throws Exception {
		try {
			manager.getTransaction().begin();
			if (email.trim().isEmpty() || username.trim().isEmpty() || username.trim().isEmpty()
					|| dataNascita.trim().isEmpty()) {
				throw new InvalidFieldsException("Tutti i campi sono obbligatori", null);
			}
			if (utenteDao.usernameAlreadyUsed(username)) {
				throw new UsernameAlreadyUsedException("Username già usata", null);
			}
			if (utenteDao.emailAlreadyUsed(email)) {
				throw new EmailAlreadyUsedException("Email già usata", null);
			}
			if (!password.equals(confermaPassword)) {
				throw new PasswordsNotMatchingException("Le passwords non sono uguali", null);
			}
			if (immagineProfilo.trim().isEmpty()) {
				throw new ImgNullException("Immagine non inserita correttamente", null);
			}
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate dataNascitaDate = LocalDate.parse(dataNascita, formatter);
			Utente newUser = new Utente(email, username, password, dataNascitaDate, immagineProfilo);
			utenteDao.create(newUser);
			manager.getTransaction().commit();
			return newUser;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public List<Utente> retrieveUsers() {
		try {
			manager.getTransaction().begin();
			List<Utente> utente = utenteDao.retrieve();
			manager.getTransaction().commit();
			return utente;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	// ok
	public Utente retrieveUserByEmail(String email) throws Exception {
		try {
			manager.getTransaction().begin();
			List<Utente> listUtente = utenteDao.retrieveByEmail(email);
			if (listUtente.size() == 0) {
				throw new UserNonExistantException("Utente non esiste", null);
			}
			manager.getTransaction().commit();
			return listUtente.get(0);
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	// ok
	public List<Utente> searchUsersByUsername(String username) throws Exception {
		try {
			manager.getTransaction().begin();
			List<Utente> utenti = utenteDao.searchByUsername(username);
			if (utenti.size() == 0) {
				throw new UserNonExistantException("La ricerca dell'utente non ha prodotto risultati!", null);
			}
			manager.getTransaction().commit();
			return utenti;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	// ok
	public Utente retrieveUserByEmailAndPassword(String email, String password) throws Exception {
		try {
			manager.getTransaction().begin();
			List<Utente> listUtente = utenteDao.retrieveByEmail(email);
			if (listUtente.size() == 0) {
				throw new UserNonExistantException("Utente non esiste", null);
			}
			Utente utente = listUtente.get(0);
			Boolean correct = utente.getPassword().equals(password);
			if (!correct) {
				throw new IncorrectPasswordException("Password sbagliata", null);
			}
			manager.getTransaction().commit();
			return utente;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public Utente deleteUser(Integer id) throws Exception {
		try {
			manager.getTransaction().begin();
			// manager.clear();
			Utente user = utenteDao.retrieveById(id).get(0);
			user.setLikes(null);
			user.setDislikes(null);
			for (Utente u : user.getFollowers()) {
				u.getSeguiti().remove(user);
			}
			for (Utente u : user.getSeguiti()) {
				u.getFollowers().remove(user);
			}
			for (Post p : user.getPosts()) {
				removePost(p);
			}
			for (Commento c : user.getComments()) {
				commentoDao.delete(c);
			}
			utenteDao.delete(user);
			manager.getTransaction().commit();
			return user;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public Boolean toggleSeguiti(Utente utenteLoggato, String utenteDaSeguire) throws Exception {
		try {
			manager.getTransaction().begin();
			Boolean isSeguito = true;
			Utente userDaSeguire = utenteDao.retrieveByUsername(utenteDaSeguire).get(0);
			if (utenteLoggato == null) {
				throw new AutorNullException("L'autore del segui e null", null);
			}
			if (utenteLoggato.getSeguiti().size() > 0 && utenteLoggato.getSeguiti().contains(userDaSeguire)) {
				utenteLoggato.getSeguiti().remove(userDaSeguire);
				userDaSeguire.getFollowers().remove(utenteLoggato);
				isSeguito = false;
			} else {
				utenteLoggato.getSeguiti().add(userDaSeguire);
				userDaSeguire.getFollowers().add(utenteLoggato);
			}
			manager.getTransaction().commit();
			return isSeguito;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public void modifyImgProfile(Utente utenteLoggato, String immagineProfilo) throws Exception {

		try {
			manager.getTransaction().begin();
			if (immagineProfilo.trim().isEmpty()) {
				throw new ImgNullException("Immagine non inserita correttamente", null);
			}
			if (utenteLoggato == null) {
				throw new AutorNullException("Utente non loggato", null);
			}
			utenteLoggato.setImmagineProfilo(immagineProfilo);
			utenteDao.update(utenteLoggato);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	/* ///////////// OPERAZIONI SU POSTS //////////////// */
	// ok
	public void insertPost(String testo, Utente autore) throws Exception {
		try {
			manager.getTransaction().begin();
			if (testo.trim().isEmpty()) {
				throw new EmptyPostTextException("Il testo del post non può essere vuoto", null);
			}
			if (autore == null) {
				throw new AutorNullException("L'autore del post e null", null);
			}
			Post newPost = new Post(testo);
			postDao.create(newPost);
			newPost.setAutore(autore);
			autore.getPosts().add(newPost);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public void insertPostWithImg(String testo, Utente autore, String imgName) throws Exception {
		try {
			manager.getTransaction().begin();
			if (testo.trim().isEmpty()) {
				throw new EmptyPostTextException("Il testo del post non può essere vuoto", null);
			}
			if (autore == null) {
				throw new AutorNullException("L'autore del post e null", null);
			}
			if (imgName.trim().isEmpty()) {
				throw new ImgNullException("Immagine non caricata", null);
			}
			Post newPost = new Post(testo);
			postDao.create(newPost);
			newPost.setAutore(autore);
			newPost.setImmagine(imgName);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	// ok
	public List<Post> retrievePosts() {
		try {
			manager.getTransaction().begin();
			List<Post> posts = postDao.retrieve();
			manager.getTransaction().commit();
			return posts;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public Post retrievePostById(Integer id) {
		try {
			manager.getTransaction().begin();
			Post post = postDao.retrieveById(id).get(0);
			manager.getTransaction().commit();
			return post;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public List<Post> retrievePostsByLikesDesc() {
		try {
			manager.getTransaction().begin();
			List<Post> posts = postDao.retrieveByLikesDesc();
			manager.getTransaction().commit();
			return posts;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public List<Post> retrievePostsByCommentsDesc() {
		try {
			manager.getTransaction().begin();
			List<Post> posts = postDao.retrieveByCommentsDesc();
			manager.getTransaction().commit();
			return posts;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public List<Post> retrievePostsByUtente(Integer id) {
		try {
			manager.getTransaction().begin();
			List<Post> posts = postDao.retrieveByUtente(id);
			manager.getTransaction().commit();
			return posts;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public List<Post> retrievePostsByUtente(String username) {
		try {
			manager.getTransaction().begin();
			List<Post> posts = postDao.retrieveByUsername(username);
			manager.getTransaction().commit();
			return posts;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public Post modifyPost(Integer id, String testo) throws Exception {
		try {
			manager.getTransaction().begin();
			List<Post> posts = postDao.retrieveById(id);
			if (testo.trim().isEmpty()) {
				throw new EmptyPostTextException("Il testo non può essere vuoto", null);
			}
			Post post = posts.get(0);
			post.setTesto(testo);
			postDao.update(post);
			manager.getTransaction().commit();
			return post;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	private void removePost(Post post) {
		for (Utente u : post.getLikes()) {
			if (u.getLikes() != null) {
				u.getLikes().remove(post);
			}
		}
		for (Utente u : post.getDislikes()) {
			if (u.getDislikes() != null) {
				u.getDislikes().remove(post);
			}
		}
		for (Commento c : post.getCommenti()) {
			commentoDao.delete(c);
		}
		post.setAutore(null);
		postDao.delete(post);
	}

	public Post deletePost(Integer id) {
		try {
			manager.getTransaction().begin();
			List<Post> posts = postDao.retrieveById(id);
			Post post = posts.get(0);
			removePost(post);
			manager.getTransaction().commit();
			return post;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public void toggleLikePost(Integer postId, Utente utente) throws Exception {
		try {
			manager.getTransaction().begin();
			if (utente == null) {
				throw new AutorNullException("L'autore del like è null", null);
			}
			if (postId == null) {
				throw new PostNullException("Il post è null", null);
			}
			Post post = postDao.retrieveById(postId).get(0);
			if (post.isLikedByUser(utente)) {
				post.getLikes().remove(utente);
				utente.getLikes().remove(post);
			} else {
				if (post.isDislikedByUser(utente)) {
					post.getDislikes().remove(utente);
					utente.getDislikes().remove(post);
				}
				post.getLikes().add(utente);
				utente.getLikes().add(post);
			}
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public void toggleDislikePost(Integer postId, Utente utente) throws Exception {
		try {
			manager.getTransaction().begin();
			if (utente == null) {
				throw new AutorNullException("L'autore del dislike è null", null);
			}
			if (postId == null) {
				throw new PostNullException("Il post è null", null);
			}
			Post post = postDao.retrieveById(postId).get(0);
			if (post.isDislikedByUser(utente)) {
				post.getDislikes().remove(utente);
				utente.getDislikes().remove(post);
			} else {
				if (post.isLikedByUser(utente)) {
					post.getLikes().remove(utente);
					utente.getLikes().remove(post);
				}
				post.getDislikes().add(utente);
				utente.getDislikes().add(post);
			}
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public void insertImgPost(Integer postId, String imgName) throws Exception {
		try {
			manager.getTransaction().begin();
			if (postId == null) {
				throw new PostNullException("Il post del commento è null", null);
			}
			if (imgName.trim().isEmpty()) {
				throw new ImgNullException("Immagine non caricata", null);
			}
			Post post = postDao.retrieveById(postId).get(0);
			post.setImmagine(imgName);
			manager.getTransaction().commit();

		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	/* ///////////// OPERAZIONI SU COMMENTI //////////////// */

	public Commento insertCommento(String testo, Utente autore, Integer postId) throws Exception {
		try {
			manager.getTransaction().begin();
			if (testo.trim().isEmpty()) {
				throw new EmptyCommentTextException("Il testo del commento non può essere vuoto", null);
			}
			if (autore == null) {
				throw new AutorNullException("L'autore del commento è null", null);
			}
			if (postId == null) {
				throw new PostNullException("Il post del commento è null", null);
			}
			Commento newComment = new Commento(testo);
			Post postCommented = postDao.retrieveById(postId).get(0);
			commentoDao.create(newComment);
			newComment.setAutore(autore);
			newComment.setPost(postCommented);
			postCommented.getCommenti().add(newComment);
			manager.getTransaction().commit();
			return newComment;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public List<Commento> retrieveComments() {
		try {
			manager.getTransaction().begin();
			List<Commento> commenti = commentoDao.retrieve();
			manager.getTransaction().commit();
			return commenti;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public Commento modifyComment(Integer commentoId, String newTesto)
			throws Exception {
		try {
			manager.getTransaction().begin();
			if (newTesto == null || newTesto.trim().equals("")) {
				throw new EmptyCommentTextException("Il testo è vuoto", null);
			}
			Commento commento = commentoDao.retrieveById(commentoId).get(0);
			commento.setTesto(newTesto);
			manager.getTransaction().commit();
			return commento;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

	public Commento deleteCommento(Integer id) {
		try {
			manager.getTransaction().begin();
			List<Commento> commenti = commentoDao.retrieveById(id);
			Commento commento = commenti.get(0);
			commentoDao.delete(commento);
			manager.getTransaction().commit();
			return commento;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			throw e;
		}
	}

}
