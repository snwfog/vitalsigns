package testing
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import mx.controls.Alert;
	
	public class DBConnection
	{
		private static var sqlc:SQLConnection;
		private static var sqls:SQLStatement;
		
		public static function init():void
		{
			var db:File = File.applicationStorageDirectory.resolvePath("testing.db");
			sqlc = new SQLConnection();
			sqls = new SQLStatement();
			sqlc.open(db);
			sqls.sqlConnection = sqlc;
			sqls.text = "CREATE TABLE IF NOT EXISTS testing_table (" +
				"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
				"runID INTEGER NOT NULL, task TEXT, time INTEGER);";
			sqls.execute();
		}
		
		public static function insert(runID:int, task:String, time:int):void
		{
			sqls.text = "INSERT INTO testing_table (runID, task, time)" +
				"VALUES(" + runID + ", '" + task + "', " + time + ");";
			sqls.execute();
			trace(sqls.getResult().rowsAffected);
		}
		
		public static function remove(id:int):void
		{
			sqls.text = "DELETE FROM testing_table WHERE id=" + id + ";";
		}
		
		public static function getMaxRunID():int
		{
			sqls.text = "SELECT runID FROM testing_table WHERE runID = (SELECT MAX(runID) FROM testing_table);";
			sqls.execute();
			var temp:Array = sqls.getResult().data;
			if (temp == null || temp.length == 0)
				return 1;
			var result:int = temp[0].runID;
			trace(result);
			return result + 1;
		}
	}
}