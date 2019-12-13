import {
  Entity,
  Column,
  BaseEntity,
  PrimaryGeneratedColumn,
  OneToMany
} from 'typeorm'
import { ObjectType, Field, Int } from 'type-graphql'

import { Routine } from './Routine'

/*
    @Field = graphql data
    @Column = database data
  */
@ObjectType()
@Entity()
export class User extends BaseEntity {
  @Field(_ => Int)
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

  @Field(_ => [Routine], { nullable: true })
  @OneToMany(
    _type => Routine,
    routine => routine.user
  )
  routines: Routine[]
}
