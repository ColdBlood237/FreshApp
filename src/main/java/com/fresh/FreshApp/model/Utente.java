package com.fresh.FreshApp.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;

@Entity
public class Utente {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private String email;
	private String username;
	private String password;
	private LocalDate dataNascita;
	private LocalDateTime dataRegistrazione;
	private String citta;
	private String paese;
	private String immagineProfilo;

	@ManyToMany
	@JoinTable(name = "utente_like", joinColumns = @JoinColumn(name = "utente_id"), inverseJoinColumns = @JoinColumn(name = "post_id"))
	private List<Post> likes = new ArrayList<Post>();

	@ManyToMany
	@JoinTable(name = "utente_dislike", joinColumns = @JoinColumn(name = "utente_id"), inverseJoinColumns = @JoinColumn(name = "post_id"))
	private List<Post> dislikes = new ArrayList<Post>();

	@ManyToMany
	@JoinTable(name = "utente_follower", joinColumns = @JoinColumn(name = "utente_id"), inverseJoinColumns = @JoinColumn(name = "follower_id"))
	private List<Utente> followers = new ArrayList<Utente>();

	@ManyToMany
	@JoinTable(name = "utente_seguito", joinColumns = @JoinColumn(name = "utente_id"), inverseJoinColumns = @JoinColumn(name = "seguito_id"))
	private List<Utente> seguiti = new ArrayList<Utente>();

	@OneToMany(mappedBy = "autore")
	@OrderBy("dataPubblicazione DESC")
	private List<Post> posts = new ArrayList<Post>();

	@OneToMany(mappedBy = "autore")
	private List<Commento> comments = new ArrayList<Commento>();

	public Utente() {

	}

	public Utente(String email, String username, String password, LocalDate dataNascita) {
		this.email = email;
		this.username = username;
		this.password = password;
		this.dataNascita = dataNascita;
		dataRegistrazione = LocalDateTime.now();
	}

	public Utente(String email, String username, String password, LocalDate dataNascita, String img) {
		this.email = email;
		this.username = username;
		this.password = password;
		this.dataNascita = dataNascita;
		dataRegistrazione = LocalDateTime.now();
		immagineProfilo = img;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public LocalDate getDataNascita() {
		return dataNascita;
	}

	public void setDataNascita(LocalDate dataNascita) {
		this.dataNascita = dataNascita;
	}

	public LocalDateTime getDataRegistrazione() {
		return dataRegistrazione;
	}

	public void setDataRegistrazione(LocalDateTime dataRegistrazione) {
		this.dataRegistrazione = dataRegistrazione;
	}

	public String getCitta() {
		return citta;
	}

	public void setCitta(String citta) {
		this.citta = citta;
	}

	public String getPaese() {
		return paese;
	}

	public void setPaese(String paese) {
		this.paese = paese;
	}

	public List<Utente> getFollowers() {
		return followers;
	}

	public void setFollowers(List<Utente> followers) {
		this.followers = followers;
	}

	public List<Utente> getSeguiti() {
		return seguiti;
	}

	public void setSeguiti(List<Utente> seguiti) {
		this.seguiti = seguiti;
	}

	public List<Post> getPosts() {
		return posts;
	}

	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}

	public List<Commento> getComments() {
		return comments;
	}

	public void setComments(List<Commento> comments) {
		this.comments = comments;
	}

	public List<Post> getLikes() {
		return likes;
	}

	public void setLikes(List<Post> likes) {
		this.likes = likes;
	}

	public List<Post> getDislikes() {
		return dislikes;
	}

	public void setDislikes(List<Post> dislikes) {
		this.dislikes = dislikes;
	}

	public String getImmagineProfilo() {
		return immagineProfilo;
	}

	public void setImmagineProfilo(String immagineProfilo) {
		this.immagineProfilo = immagineProfilo;
	}

	@Override
	public String toString() {
		return "Utente [email=" + email + ", username=" + username + ", password=" + password + ", dataNascita="
				+ dataNascita + ", dataRegistrazione=" + dataRegistrazione + ", citta=" + citta + ", paese=" + paese
				+ "]";
	}

	@Override
	public boolean equals(Object u) {
		if (u instanceof Utente) {
			Utente user = (Utente) u;
			return this.id.equals(user.getId());
		}
		return false;
	}

	@Override
	public int hashCode() {
		return id.hashCode();
	}

}
