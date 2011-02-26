class FakeUser

  include Typus::Orm::ActiveRecord::User::InstanceMethods

  def id
    0
  end

  def can?(*args)
    true
  end

  def cannot?(*args)
    !can?(*args)
  end

  def is_root?
    true
  end

  def is_not_root?
    !is_root?
  end

  def applications
    Typus.applications
  end

  def application(name)
    Typus.application(name)
  end

  def status
    true
  end

end
