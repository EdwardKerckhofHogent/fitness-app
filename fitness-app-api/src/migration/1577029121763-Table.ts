import {MigrationInterface, QueryRunner} from "typeorm";

export class Table1577029121763 implements MigrationInterface {
    name = 'Table1577029121763'

    public async up(queryRunner: QueryRunner): Promise<any> {
        await queryRunner.query("ALTER TABLE `exercise_set` DROP FOREIGN KEY `FK_2e7ff75c9840bea1160155981c2`", undefined);
        await queryRunner.query("ALTER TABLE `exercise` DROP FOREIGN KEY `FK_ca88fd2308d10b1b24fbf7fa853`", undefined);
        await queryRunner.query("ALTER TABLE `exercise_set` ADD CONSTRAINT `FK_2e7ff75c9840bea1160155981c2` FOREIGN KEY (`exerciseId`) REFERENCES `exercise`(`id`) ON DELETE CASCADE ON UPDATE CASCADE", undefined);
        await queryRunner.query("ALTER TABLE `exercise` ADD CONSTRAINT `FK_ca88fd2308d10b1b24fbf7fa853` FOREIGN KEY (`routineId`) REFERENCES `routine`(`id`) ON DELETE CASCADE ON UPDATE CASCADE", undefined);
    }

    public async down(queryRunner: QueryRunner): Promise<any> {
        await queryRunner.query("ALTER TABLE `exercise` DROP FOREIGN KEY `FK_ca88fd2308d10b1b24fbf7fa853`", undefined);
        await queryRunner.query("ALTER TABLE `exercise_set` DROP FOREIGN KEY `FK_2e7ff75c9840bea1160155981c2`", undefined);
        await queryRunner.query("ALTER TABLE `exercise` ADD CONSTRAINT `FK_ca88fd2308d10b1b24fbf7fa853` FOREIGN KEY (`routineId`) REFERENCES `routine`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION", undefined);
        await queryRunner.query("ALTER TABLE `exercise_set` ADD CONSTRAINT `FK_2e7ff75c9840bea1160155981c2` FOREIGN KEY (`exerciseId`) REFERENCES `exercise`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION", undefined);
    }

}
