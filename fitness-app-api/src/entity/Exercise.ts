import {
  Entity,
  Column,
  BaseEntity,
  ManyToOne,
  PrimaryGeneratedColumn
} from 'typeorm'
import { ObjectType, Field, ID } from 'type-graphql'
import { Routine } from './Routine'

/*
  @Field = graphql data
  @Column = database data
*/
@ObjectType()
@Entity()
export class Exercise extends BaseEntity {
  @Field(_ => ID)
  @PrimaryGeneratedColumn()
  id: number

  @Field()
  @Column({ type: 'varchar', nullable: false })
  name: string

  @Column('int') routineId: number

  @ManyToOne(
    _type => Routine,
    routine => routine.exercises
  )
  routine: Routine
}
