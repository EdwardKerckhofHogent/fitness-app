import { Entity, Column, BaseEntity, PrimaryGeneratedColumn } from 'typeorm'
import { ObjectType, Field, ID } from 'type-graphql'

/*
    @Field = graphql data
    @Column = database data
  */
@ObjectType()
@Entity()
export class User extends BaseEntity {
  @Field(_ => ID)
  @PrimaryGeneratedColumn()
  id: number

  @Field()
  @Column({ type: 'varchar', unique: true })
  email: string

  @Column('int', { default: 0 })
  tokenVersion: number

  // Dont return password to graphql
  @Column()
  password: string

  // Change to false when sendEmail is implemented
  @Column('bool')
  confirmed: boolean = true
}
