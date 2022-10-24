export class Config {
  public static getMoonogseConfig = () => {
    console.log(
      'Connected',
      process.env.MONGO_DB_URL || 'mongodb://localhost:27017/fdoc',
    );
    return process.env.MONGO_DB_URL || 'mongodb://localhost:27017/fdoc';
  };
}
