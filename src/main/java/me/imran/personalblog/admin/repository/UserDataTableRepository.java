package me.imran.personalblog.admin.repository;

/*IMPORT_MODEL*/
import me.imran.personalblog.admin.model.User;
import org.springframework.data.jpa.datatables.repository.DataTablesRepository;
import org.springframework.stereotype.Repository;

/**
 * @author Imran Hossain
 */
@Repository
public interface UserDataTableRepository extends DataTablesRepository<User, Integer>{
}

