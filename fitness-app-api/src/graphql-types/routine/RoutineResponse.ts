import { ObjectType, Field } from 'type-graphql'
import { Routine } from '../../entity/Routine'
import { FieldError } from '../FieldError'

@ObjectType()
export class RoutineResponse {
  @Field(() => Routine, { nullable: true })
  routine?: Routine

  @Field(() => [Routine], { nullable: true })
  routines?: Routine[]

  @Field(() => [FieldError], { nullable: true })
  errors?: FieldError[]
}
