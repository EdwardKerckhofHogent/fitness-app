import {MigrationInterface, QueryRunner} from "typeorm";

export class Table1576605665554 implements MigrationInterface {
    name = 'Table1576605665554'

    public async up(queryRunner: QueryRunner): Promise<any> {
        await queryRunner.query("ALTER TABLE `exercise_set` DROP FOREIGN KEY `FK_2e7ff75c9840bea1160155981c2`", undefined);
        await queryRunner.query("ALTER TABLE `exercise_set` ADD CONSTRAINT `FK_2e7ff75c9840bea1160155981c2` FOREIGN KEY (`exerciseId`) REFERENCES `exercise`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION", undefined);
    }

    public async down(queryRunner: QueryRunner): Promise<any> {
        await queryRunner.query("ALTER TABLE `exercise_set` DROP FOREIGN KEY `FK_2e7ff75c9840bea1160155981c2`", undefined);
        await queryRunner.query("ALTER TABLE `exercise_set` ADD CONSTRAINT `FK_2e7ff75c9840bea1160155981c2` FOREIGN KEY (`exerciseId`) REFERENCES `exercise`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION", undefined);
    }

}
