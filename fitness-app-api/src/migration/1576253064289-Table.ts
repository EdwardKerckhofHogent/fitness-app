import {MigrationInterface, QueryRunner} from "typeorm";

export class Table1576253064289 implements MigrationInterface {
    name = 'Table1576253064289'

    public async up(queryRunner: QueryRunner): Promise<any> {
        await queryRunner.query("CREATE TABLE `routine` (`id` int NOT NULL AUTO_INCREMENT, `name` varchar(255) NOT NULL, `userId` int NOT NULL, PRIMARY KEY (`id`)) ENGINE=InnoDB", undefined);
        await queryRunner.query("ALTER TABLE `routine` ADD CONSTRAINT `FK_c45924a1b42b6620e435e677cb5` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION", undefined);
    }

    public async down(queryRunner: QueryRunner): Promise<any> {
        await queryRunner.query("ALTER TABLE `routine` DROP FOREIGN KEY `FK_c45924a1b42b6620e435e677cb5`", undefined);
        await queryRunner.query("DROP TABLE `routine`", undefined);
    }

}
