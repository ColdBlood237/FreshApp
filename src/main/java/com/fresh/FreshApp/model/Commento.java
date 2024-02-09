package com.fresh.FreshApp.model;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Commento {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private String testo;
	private LocalDateTime dataPubblicazione;
	private String immagine;

	@ManyToOne
	@JoinColumn(name = "utente_id")
	private Utente autore;

	@ManyToOne
	@JoinColumn(name = "post_id")
	private Post post;

	public Commento() {

	}

	public Commento(String testo) {
		this.testo = testo;
		dataPubblicazione = LocalDateTime.now();
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTesto() {
		return testo;
	}

	public void setTesto(String testo) {
		this.testo = testo;
	}

	public LocalDateTime getDataPubblicazione() {
		return dataPubblicazione;
	}

	public void setDataPubblicazione(LocalDateTime dataPubblicazione) {
		this.dataPubblicazione = dataPubblicazione;
	}

	public String getImmagine() {
		return immagine;
	}

	public void setImmagine(String immagine) {
		this.immagine = immagine;
	}

	public Utente getAutore() {
		return autore;
	}

	public void setAutore(Utente autore) {
		this.autore = autore;
	}

	public Post getPost() {
		return post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

	@Override
	public String toString() {
		return "Commento [id=" + id + ", testo=" + testo + ", dataPubblicazione=" + dataPubblicazione + ", immagine="
				+ immagine + ", autore=" + autore + ", post=" + post + "]";
	}

	@Override
	public boolean equals(Object c) {
		if (c instanceof Commento) {
			Commento comment = (Commento) c;
			return this.id.equals(comment.getId());
		}
		return false;
	}

	@Override
	public int hashCode() {
		return id.hashCode();
	}

}
