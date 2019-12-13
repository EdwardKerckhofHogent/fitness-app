import {
  Entity,
  Column,
  BaseEntity,
  PrimaryGeneratedColumn,
  ManyToOne
} from 'typeorm'
import { ObjectType, Field, Int } from 'type-graphql'

import { User } from './User'

/*
    @Field = graphql data
    @Column = database data
  */
@ObjectType()
@Entity()
export class Routine extends BaseEntity {
  @Field(_ => Int)
  @PrimaryGeneratedColumn()
  id: number

  @Field()
  @Column({ type: 'varchar', nullable: false })
  name: string

  @Column('int') userId: number

  @Field(_ => User)
  @ManyToOne(
    _type => User,
    user => user.routines
  )
  user: User
}
