package com.fresh.FreshApp.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Post {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private LocalDateTime dataPubblicazione;
	private String testo;
	private String immagine;
	private String video;
	@ManyToMany(mappedBy = "likes")
	private List<Utente> likes = new ArrayList<Utente>();
	@ManyToMany(mappedBy = "dislikes")
	private List<Utente> dislikes = new ArrayList<Utente>();

	@ManyToOne
	@JoinColumn(name = "utente_id")
	private Utente autore;

	@OneToMany(mappedBy = "post")
	private List<Commento> commenti = new ArrayList<Commento>();

	public Post() {

	}

	public Post(String testo) {
		this.testo = testo;
		this.dataPubblicazione = LocalDateTime.now();
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public LocalDateTime getDataPubblicazione() {
		return dataPubblicazione;
	}

	public String getTesto() {
		return testo;
	}

	public void setTesto(String testo) {
		this.testo = testo;
	}

	public String getImmagine() {
		return immagine;
	}

	public void setImmagine(String immagine) {
		this.immagine = immagine;
	}

	public String getVideo() {
		return video;
	}

	public void setVideo(String video) {
		this.video = video;
	}

	public List<Utente> getLikes() {
		return likes;
	}

	public void setLikes(List<Utente> likes) {
		this.likes = likes;
	}

	public List<Utente> getDislikes() {
		return dislikes;
	}

	public void setDislikes(List<Utente> dislikes) {
		this.dislikes = dislikes;
	}

	public Utente getAutore() {
		return autore;
	}

	public void setAutore(Utente autore) {
		this.autore = autore;
	}

	public List<Commento> getCommenti() {
		return commenti;
	}

	public void setCommenti(List<Commento> commenti) {
		this.commenti = commenti;
	}

	public Boolean isLikedByUser(Utente user) {
		return likes.contains(user);
	}

	public Boolean isDislikedByUser(Utente user) {
		return dislikes.contains(user);
	}

	@Override
	public String toString() {
		return "Post [dataPubblicazione=" + dataPubblicazione + ", testo=" + testo + ", immagine=" + immagine
				+ ", video=" + video + ", likes=" + likes + ", dislikes=" + dislikes + ", autore=" + autore + "]";
	}

	@Override
	public boolean equals(Object p) {
		if (p instanceof Post) {
			Post post = (Post) p;
			return this.id.equals(post.getId());
		}
		return false;
	}

	@Override
	public int hashCode() {
		return id.hashCode();
	}

}
