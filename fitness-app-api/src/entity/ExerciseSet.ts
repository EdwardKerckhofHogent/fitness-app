import {
  Entity,
  Column,
  BaseEntity,
  ManyToOne,
  PrimaryGeneratedColumn
} from 'typeorm'
import { ObjectType, Field, Int } from 'type-graphql'
import { Exercise } from './Exercise'

/*
    @Field = graphql data
    @Column = database data
  */
@ObjectType()
@Entity()
export class ExerciseSet extends BaseEntity {
  @Field(_ => Int)
  @PrimaryGeneratedColumn()
  id: number

  @Field()
  @Column({ type: 'float', nullable: false })
  kg: number

  @Field()
  @Column({ type: 'smallint', nullable: false })
  reps: number

  @Column('int') exerciseId: number

  @ManyToOne(
    _type => Exercise,
    exercise => exercise.sets
  )
  exercise: Exercise
}
