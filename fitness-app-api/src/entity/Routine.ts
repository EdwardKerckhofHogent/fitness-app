import {
  Entity,
  Column,
  BaseEntity,
  PrimaryGeneratedColumn,
  ManyToOne,
  OneToMany
} from 'typeorm'
import { ObjectType, Field, Int } from 'type-graphql'

import { User } from './User'
import { Exercise } from './Exercise'

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

  @Field(_ => [Exercise], { nullable: true })
  @OneToMany(
    _type => Exercise,
    exercise => exercise.routine
  )
  exercises: Exercise[]

  @Field(_ => Int)
  @Column('int')
  userId: number

  @ManyToOne(
    _type => User,
    user => user.routines
  )
  user: User
}
