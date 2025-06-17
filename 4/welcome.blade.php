<p>
    <form action="{{ route('test.get') }}">
        <button type="submit">Получить данные</button>
        <span>{{ session('value') }}</span>
    </form>
</p>
<p>
    <form method="POST" action="{{ route('test.check') }}">
        @csrf
        <input type="hidden" name="value" value="{{ session('value') }}">
        <button type="submit">Отправить результат теста</button>
        <span>{{ session('message') }}</span>
    </form>
</p>
