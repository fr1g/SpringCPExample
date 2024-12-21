package su.kami.demo;

import com.google.gson.GsonBuilder;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import su.kami.demo.DataAccess.DAO.EmployeeManage;
import su.kami.demo.DataAccess.DAO.RelatedTrader;
import su.kami.demo.Models.Employee;
import su.kami.demo.Models.Trader;
import su.kami.demo.Models.enums.EEmpType;
import su.kami.demo.Models.enums.ETraderType;
import su.kami.demo.Models.enums.EnumTemplate;
import su.kami.demo.Shared.SharedStatics;
import su.kami.demo.utils.GsonDateHelper;
import su.kami.demo.utils.GsonEnumTemplatedHelper;
import su.kami.demo.utils.GsonRelatedObjectHelper;
import su.kami.demo.utils.MyTableHelper;

import java.util.Date;

@SpringBootApplication
public class DemoApplication {

	public static void main(String[] args) {

		SharedStatics.dynamicShared =
				SharedStatics.getServices(new ClassPathXmlApplicationContext("app-context.xml"));

		SharedStatics.publicTableHelper = new MyTableHelper<String>();
//		SharedStatics.publicTableHelper.inDebug();

		var builder = new GsonBuilder();
		builder.registerTypeAdapter(Date.class, new GsonDateHelper());
		builder.registerTypeAdapter(EEmpType.class, new GsonEnumTemplatedHelper<EEmpType>());
		builder.registerTypeAdapter(ETraderType.class, new GsonEnumTemplatedHelper<ETraderType>());
		builder.registerTypeAdapter(Trader.class, new GsonRelatedObjectHelper<Trader>((RelatedTrader)SharedStatics.dynamicShared.services.get("TraderService").lendAgent()));

		SharedStatics.jsonHandler = builder.create();

		SpringApplication.run(DemoApplication.class, args);

	}

}
