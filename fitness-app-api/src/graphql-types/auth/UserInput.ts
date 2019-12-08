import { InputType, Field } from 'type-graphql'
import { Length } from 'class-validator'
import { PasswordInput } from './shared/PasswordInput'

@InputType()
export class UserInput extends PasswordInput {
  @Field()
  @Length(5)
  email: string

  @Field({ nullable: true })
  @Length(5)
  repeatPassword: string
}
