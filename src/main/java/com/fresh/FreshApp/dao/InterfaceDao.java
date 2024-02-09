package com.fresh.FreshApp.dao;

import java.util.List;

public interface InterfaceDao<T> {
	public T create (T ref);
	public List<T> retrieve();
	public T update(T ref);
	public void delete(T ref);
}

