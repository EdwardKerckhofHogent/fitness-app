import {
  Entity,
  Column,
  BaseEntity,
  ManyToOne,
  PrimaryGeneratedColumn,
  OneToMany
} from 'typeorm'
import { ObjectType, Field, Int } from 'type-graphql'

import { Routine } from './Routine'
import { ExerciseSet } from './ExerciseSet'

/*
  @Field = graphql data
  @Column = database data
*/
@ObjectType()
@Entity()
export class Exercise extends BaseEntity {
  @Field(_ => Int)
  @PrimaryGeneratedColumn()
  id: number

  @Field()
  @Column({ type: 'varchar', nullable: false })
  name: string

  @Field(_ => Int)
  @Column('int')
  routineId: number

  @ManyToOne(
    _type => Routine,
    routine => routine.exercises
  )
  routine: Routine

  @Field(_ => [ExerciseSet], { nullable: true })
  @OneToMany(
    _type => ExerciseSet,
    set => set.exercise,
    { cascade: true }
  )
  sets: ExerciseSet[]
}
