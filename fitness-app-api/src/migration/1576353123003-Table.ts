import {MigrationInterface, QueryRunner} from "typeorm";

export class Table1576353123003 implements MigrationInterface {
    name = 'Table1576353123003'

    public async up(queryRunner: QueryRunner): Promise<any> {
        await queryRunner.query("CREATE TABLE `exercise_set` (`id` int NOT NULL AUTO_INCREMENT, `kg` float NOT NULL, `reps` smallint NOT NULL, `exerciseId` int NOT NULL, PRIMARY KEY (`id`)) ENGINE=InnoDB", undefined);
        await queryRunner.query("ALTER TABLE `exercise_set` ADD CONSTRAINT `FK_2e7ff75c9840bea1160155981c2` FOREIGN KEY (`exerciseId`) REFERENCES `exercise`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION", undefined);
    }

    public async down(queryRunner: QueryRunner): Promise<any> {
        await queryRunner.query("ALTER TABLE `exercise_set` DROP FOREIGN KEY `FK_2e7ff75c9840bea1160155981c2`", undefined);
        await queryRunner.query("DROP TABLE `exercise_set`", undefined);
    }

}
