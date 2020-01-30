abstract class Mapper<I, O> {
  const Mapper();

  O mapFrom(I entity);

  I mapTo(O model);
}
