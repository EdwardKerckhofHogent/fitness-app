import {MigrationInterface, QueryRunner} from "typeorm";

export class Table1575747185698 implements MigrationInterface {
    name = 'Table1575747185698'

    public async up(queryRunner: QueryRunner): Promise<any> {
        await queryRunner.query("ALTER TABLE `user` ADD `tokenVersion` int NOT NULL DEFAULT 0", undefined);
    }

    public async down(queryRunner: QueryRunner): Promise<any> {
        await queryRunner.query("ALTER TABLE `user` DROP COLUMN `tokenVersion`", undefined);
    }

}
