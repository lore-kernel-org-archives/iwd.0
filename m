Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E150139B
	for <iwd@lists.linux.dev>; Sun, 11 Jun 2023 03:26:47 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b02d0942caso15739865ad.1
        for <iwd@lists.linux.dev>; Sat, 10 Jun 2023 20:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mikesilva.com; s=google; t=1686454007; x=1689046007;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StsiEbDv8Z+4xaxotB89BZqGqN1JsK3LHb+zkKuQlYs=;
        b=NDnpZeaunVakgmXwMX6xjH5NVU8u/4DJL03oV8spxZvRB1iGjzxxMFbZLAydMiFhlE
         U//MEle+RsWsO3xJkyicGvvB5EsLyi5RIS9+TqNP4JiZNaDZw0nQ4rxec/WEU02H1O7Q
         z3YBaGmnZsLcl0q7Xt/F5mQiV/wfH7yrZ8qlMe4F9IOR4HNBaMQKc1xNEkHaEM9m+LEE
         K9xnKFp1GH7vlAwMPJHxu3B6tydU9CvYVJaNeZUl+ZfgTROiOpdshU5+94QJOpsbvrWI
         K6Pb1wegY4xS5CTny4tGlkfswz9h0KdbElWavEHWFECV0t2dReX6IBWmcobreC7QERzk
         ql+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686454007; x=1689046007;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StsiEbDv8Z+4xaxotB89BZqGqN1JsK3LHb+zkKuQlYs=;
        b=Q1j9vEZWIjPOSnObPVtB6sgSxr/ANVseYOd9eULPzjzo9RktCxql3w88hXCSYxZr7C
         5Au+jqZ1gpY2n60F/X5ivKC3c+4eDEfqXWI0OOxwI/GD62ukk37ESxA/4tGh9UcHoK7K
         3bTa7twTXSUIMM758jLtQFqu2iZW1W1qLSICOMASiNwzgbORUeLQVjpMned17X0nZK0L
         KmIZOaBDHYygDPYqmvijKL5k5qJRfETnVbUSFsLSjhwWqYQ2yCTd5aLpDxnHWJT1TAWY
         PO6N+OofXHX6TLq67Z2ntng+KQfFkQpu4jLnZJ0N8Mh2BD4IWUeqRDX9zBGcXdfuvv0y
         ReVA==
X-Gm-Message-State: AC+VfDy4feDiJ99odBY8Np1xrXJoLxpaVuEuJmVYAuMc4X/GYpGe8TeO
	C8+hLmlPuN2DygL4wxkbomzXxbt/1hMdjuy30lT7Cw==
X-Google-Smtp-Source: ACHHUZ6QPNwqy4S7ogrrqR3ipp0VVwxMedRl8EER0ce/YKw8ClQ/cBF3v5+LsIbKXb+suJcSXj/owA==
X-Received: by 2002:a17:902:76ca:b0:1b1:a4e2:a2ce with SMTP id j10-20020a17090276ca00b001b1a4e2a2cemr2759096plt.20.1686454006649;
        Sat, 10 Jun 2023 20:26:46 -0700 (PDT)
Received: from smtpclient.apple ([2001:5a8:4322:b800:b171:9a6:ccc5:293c])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902b70500b001aad714400asm5648830pls.229.2023.06.10.20.26.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Jun 2023 20:26:46 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: powersave support
From: Mike Silva <mike.silva@mikesilva.com>
In-Reply-To: <772f5654-5232-6aa1-5ef1-601585d408f0@gmail.com>
Date: Sat, 10 Jun 2023 20:26:35 -0700
Cc: Marcel Holtmann <marcel@holtmann.org>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <D71AF564-66F5-4542-91D2-E226FE078D94@mikesilva.com>
References: <9EF567DC-15CC-40C0-9AF8-D69E27B81ACF@mikesilva.com>
 <f5ccf370-5197-c9a4-61b6-2a130c7242de@gmail.com>
 <4F32B57B-3517-46EA-97F6-2B5DC172B952@holtmann.org>
 <66b05814-cb78-40c7-929b-0e2ffa2027a6@gmail.com>
 <04BED22D-EBF1-47B8-AD51-01DCC2CA4138@holtmann.org>
 <772f5654-5232-6aa1-5ef1-601585d408f0@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3731.600.7)

Hello,

> On Jun 9, 2023, at 3:07 PM, James Prestwood <prestwoj@gmail.com> =
wrote:
>=20
> Hi,
>=20
> On 5/9/23 9:09 AM, Marcel Holtmann wrote:
>> Hi James,
>>>>>> Does IWD support disabling/enabling WiFi powersave/power =
management?
>>>>>=20
>>>>> No, currently it doesn't.
>>>>>=20
>>>>>> Perhaps, I=E2=80=99m failing in finding it in the documentation. =
It=E2=80=99s possible to do this as needed with ifconfig, iwconfig, or =
NetworkManager, or to permanently configure them to enable or disable it =
at boot..
>>>>>> If IWD doesn=E2=80=99t support this, it would be nice enhancement =
if IWD could when managing the adapter/connection, as some drivers do a =
poor job of handling powersave being on.
>>>>>=20
>>>>> Yes, I've recently seen instances of drivers handling this poorly. =
Are you envisioning something like these other tools, where power save =
is just toggled on/off?
>>>>>=20
>>>>> I think this could be done, and actually we do this manually every =
boot using iwconfig in the software stack I work with. The tricky part =
is PS is done per-interface and IWD doesn't have any concept of =
per-interface configurations.
>>>> if anybody uses iwconfig, then the problem is already there. =
iwconfig
>>>> is an WEXT tool and deprecated. The driver is broken.
>>>=20
>>> It doesn't have much to do with the tool, its just an NL80211 API to =
toggle power save. But yes, the driver is broken if it can't handle this =
properly... but this is the world we live in.
>>>=20
>>> The reason I'm interested though is because there is no nice way to =
disable power save "automatically" unless you use NetworkManager. Apart =
from hooking in a script to disable it with iw/iwconfig (which we =
currently do). An option in IWD would be convenient.
>>>=20
>>>>> Denis might have preferences on this? but my initial thoughts =
would be something like:
>>>>>=20
>>>>> [General.wlan0]
>>>>> PowerSave=3D{on,off}
>>>> You can't tie anything to interface names. Then can change and are
>>>> basically random names. The most you can do is tie it to the phy
>>>> and its mode of operation.
>>>=20
>>> True, it would have to be per-phy. But this too has the same problem =
if its a hotplug device...
>>>=20
>>> We do have this concept of driver_flags already, for interface =
removal, but I'm not sure if power save is something that EVERYONE will =
want to disable for a given driver. Maybe it works for some use cases =
but not others.
>> we already have this:
>> enum driver_flag {
>>         DEFAULT_IF =3D 0x1,
>>         FORCE_PAE =3D 0x2,
>> };
>> struct driver_info {
>>         const char *prefix;
>>         unsigned int flags;
>> };
>> /*
>>  * The out-of-tree rtl88x2bu crashes the kernel hard if default =
interface is
>>  * destroyed.  It seems many other drivers are built from the same =
source code
>>  * so we set the DEFAULT_IF flag for all of them.  Unfortunately =
there are
>>  * in-tree drivers that also match these names and may be fine.
>>  */
>> static const struct driver_info driver_infos[] =3D {
>>         { "rtl81*",          DEFAULT_IF },
>>         { "rtl87*",          DEFAULT_IF },
>>         { "rtl88*",          DEFAULT_IF },
>>         { "rtw_*",           DEFAULT_IF },
>>         { "brcmfmac",        DEFAULT_IF },
>>         { "bcmsdh_sdmmc",    DEFAULT_IF },
>> };
>> It is hardcoded and obviously awful as that, but you could add a flag
>> for power save mode. However I think this needs to move into a =
configuration
>> file somewhere that can match and flag drivers and/or hardware.
>=20
> After looking into power save more I decided to revisit this sooner =
than later. I initially thought you could get a persistent PS setting by =
a script that runs at boot but the way IWD works deleting the default =
interface actually blows away any PS setting because its tied to the =
interface. So you would actually have to wait for IWD to start and =
create interfaces, then set PS off, which is problematic if you don't =
have a daemon monitoring IWD's state. It would be convenient for IWD to =
set it once it creates the interface.

I=E2=80=99m annoyed that I didn=E2=80=99t articulate that this was a =
further problem I was hoping IWD controlling PS would address. Thanks.

>=20
> So now I'm trying to come up with a clean way of making driver quirks =
like this configurable via main.conf. I think we should keep this static =
list for known offenders and tack it onto the end of a dynamic list that =
gets generated at runtime based on any driver quirks in main.conf
>=20
> The configuration format is where it gets kinda nasty. I'm thinking of =
having a "DriverQuirks" group where each key corresponds to a driver =
flag, and each value is a comma-separated list of glob matches:
>=20
> [DriverQuirks]
> DefaultInterface=3Drtl81*,rtl87*,rtl88*,brcmfmac
> PowerSaveOff=3Dath10k,iwlwifi,rl*
> ForcePae=3Ddrv1,drv2,etc

You=E2=80=99ll find that among the Mediatek wifi chipsets, the ones =
based on the design they=E2=80=99ve purchased from Realtek also carry =
forward the buggy powersave. I believe it was one of the rt chipsets =
already in your list. The Mediateks are the mt76, and its derived =
chipesets like the mt7921. You can find a list of them, here:
https://wireless.wiki.kernel.org/en/users/drivers/mediatek

I=E2=80=99m not sure how complete that list is, but it at least captures =
a bunch of those which are derived from rt and the rt drivers.

A passing glance at their mailing list looks like they may have been =
doing some work to address this on some of these chipsets, but in my =
experience it=E2=80=99s not fixed. (And, I=E2=80=99m running their =
latest firmware from their git repository.)

>=20
> One downside here is you may have duplicates between each quirk. Using =
driver names as the keys would remove duplication, but loses the ability =
to glob match since '*' is not a valid key character (maybe this is fine =
though).
>=20
> I'm open to suggestions here. Trying to find a happy medium between =
readability and parse-ability.
>=20
> Thanks,
> James
>=20
>> Regards
>> Marcel


