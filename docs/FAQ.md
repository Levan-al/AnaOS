# FAQ (draft)

User-facing answers for website later (`WEBSITE.md`). Keep honest.

## Is AnaOS GrapheneOS?

No. AnaOS is a separate project. Some hardening ideas and forks may track
GrapheneOS/AOSP; branding, keys, and update hosts are AnaOS-only
(`ORG_ANAOS_REBRAND.md`).

## Is this the same as qizimarket AI Ops?

No. That product is separate (`PRODUCT_SCOPE.md`). AnaOS may ship optional
on-device OCR/STT with consent; it does not phone home to AI Ops by default.

## Do I need Google Play?

No. Sandboxed Play is optional (`SANDBOXED_PLAY.md`).

## Where do updates come from?

Only AnaOS update servers / signed packages (`UPDATE_SERVER.md`). Not Play.

## Are private keys in the cloud?

No. Release/AVB keys are offline (`KEY_CEREMONY.md`).

## Can I lock the bootloader?

Goal: yes, with AnaOS AVB key on supported Pixels (`AVB_BOOTLOADER_LOCK.md`).
Not available until signed device images exist.

## Why no public downloads yet?

First emulator/device bring-up still in progress; do not trust unsigned test
builds as “official AnaOS.”
