# action-PackSquash

[ComunidadAylas/PackSquash](https://github.com/ComunidadAylas/PackSquash) を使って、Minecraft のリソースパックから最適化したファイルを出力するするツール。

> 可能な限り最高の圧縮を実現する Minecraft リソースパック用最適化ツール。これにより、効率的な配布と短いダウンロード時間でテクスチャを反映させることができます。参考例として、デフォルトのオプションを使用すると、ハリーポッターリソースパック v1.6.2 の ZIP ファイルサイズが 118MiB から 57MiB になり、51.69% 縮小されました。
> <details>
> <summary>原文</summary>
> A Minecraft resource pack optimizer which aims to achieve the best possible compression, which allows for efficient distribution and slightly improved load times in the game, at good speed. Anecdotal evidence shows that, with the default options, it is able to reduce the size of the Witchcraft & Wizardary resource pack ZIP file by Floo Network (version 1.6.2) from 118 MiB to 57 MiB, a 51.69% size reduction.
> </details>

- [English](README.md)
- 日本語

## `[推奨]` ワークフローのオプションを利用する

### 入力

| 設定 | デフォルト | 説明 |
|---|---|---|
| path | **必須** | テクスチャパックフォルダへの相対パス |
| [skip_pack_icon](https://github.com/ComunidadAylas/PackSquash/wiki/Settings-file-format#skip_pack_icon) | `false` | true にすると pack.png は最適化後のファイルに含みません。Minecraft 1.16.3 以降は、サーバーリソースパックのアイコンが表示されないので、この最適化に問題はありません。 |
| [strict_zip_spec_compliance](https://github.com/ComunidadAylas/PackSquash/wiki/Settings-file-format#strict_zip_spec_compliance) | `true` | false にすると ZIP ファイルを生成します。現在の Minecraft リソースパックの ZIP ファイルパーサーでは通常どおり読み取り可能であり、ZIP ファイルを利用できないわけではありませんが、一部のプログラムで拒否される場合があります。 |
| [compress_already_compressed_files](https://github.com/ComunidadAylas/PackSquash/wiki/Settings-file-format#compress_already_compressed_files) | `false` | true にすると、既に圧縮されているファイルを再圧縮して、出力します。 |
| [ignore_system_and_hidden_files](https://github.com/ComunidadAylas/PackSquash/wiki/Settings-file-format#ignore_system_and_hidden_files) | `true` | true にすると、明らかに Minecraft で使用しないファイルや隠しファイルの進行状況メッセージを出力しません。 |
| [allow_mod_optifine](https://github.com/ComunidadAylas/PackSquash/wiki/Settings-file-format#allowed_mods) | `false` | .properties ファイルを追加します。適切なカスタムエンティティモデルをサポートするために .jpm と .jem も追加されています。 |
| [sampling_frequency](https://github.com/ComunidadAylas/PackSquash/wiki/Settings-file-format#sampling_frequency) | `32000` | オーディオファイルがリサンプリングされる周波数 (Hz) を指定します。 |
| [target_pitch](https://github.com/ComunidadAylas/PackSquash/wiki/Settings-file-format#target_pitch) | `1.0` | ゲーム内でのピッチを設定します。これにより、オーディオが元の速度で再生され、ピッチやテンポに影響します。 |
| [minimum_bitrate](https://github.com/ComunidadAylas/PackSquash/wiki/Settings-file-format#minimum_bitrate) | `40000` | OGG エンコーダーがオーディオ信号を表すために使用しようとする最小ビット毎秒 (bps) を指定します。 |
| [maximum_bitrate](https://github.com/ComunidadAylas/PackSquash/wiki/Settings-file-format#maximum_bitrate) | `96000` | OGG エンコーダーがオーディオ信号を表すために使用しようとする最大ビット毎秒 (bps) を指定します。 |
| [quantize_image](https://github.com/ComunidadAylas/PackSquash/wiki/Settings-file-format#quantize_image) | `true` | true にすると、ファイル容量を節約するために、PNG 画像に対してパレット量子化を実行し、色の種類を最大 256 に減らします。 |
| output | `optimize-texture` | 最適化後のファイル名。 |

### Example Usage
※ リソースパックフォルダは `texture` です。

リポジトリにプッシュすると、GitHubActions のアーティファクトとして、最適化したテクスチャパックをダウンロードすることができます。

##### .github/workflows/packsquash.yml
```yaml
name: Optimize ResoucePack
on: [push]
jobs:
  packsquash:
    name: Optimize
    runs-on: ubuntu-latest
    steps:
      - name: Clone Repository
        uses: actions/checkout@master
        with:
          fetch-depth: 1
      - name: Run PackSquash
        uses: sya-ri/action-PackSquash@v1.0.0
        with:
          path: texture
      - name: Output Optimized
        uses: actions/upload-artifact@v2
        with:
          name: optimize-texture
          path: optimize-texture
```

## `[高度]` 独自の設定ファイルを利用する

### 入力

| 設定 | デフォルト | 説明 |
|---|---|---|
| setting_file | **必須** | PackSquash コンフィグファイルへの相対パス。 [ここ](https://github.com/ComunidadAylas/PackSquash/wiki/Settings-file-format) を見てください。 |
