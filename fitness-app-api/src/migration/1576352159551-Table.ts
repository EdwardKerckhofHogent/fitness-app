import {MigrationInterface, QueryRunner} from "typeorm";

export class Table1576352159551 implements MigrationInterface {
    name = 'Table1576352159551'

    public async up(queryRunner: QueryRunner): Promise<any> {
        await queryRunner.query("CREATE TABLE `exercise` (`id` int NOT NULL AUTO_INCREMENT, `name` varchar(255) NOT NULL, `routineId` int NOT NULL, PRIMARY KEY (`id`)) ENGINE=InnoDB", undefined);
        await queryRunner.query("ALTER TABLE `exercise` ADD CONSTRAINT `FK_ca88fd2308d10b1b24fbf7fa853` FOREIGN KEY (`routineId`) REFERENCES `routine`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION", undefined);
    }

    public async down(queryRunner: QueryRunner): Promise<any> {
        await queryRunner.query("ALTER TABLE `exercise` DROP FOREIGN KEY `FK_ca88fd2308d10b1b24fbf7fa853`", undefined);
        await queryRunner.query("DROP TABLE `exercise`", undefined);
    }

}
