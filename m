Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC8C5697
	for <iwd@lists.linux.dev>; Fri, 17 Feb 2023 11:41:13 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id j5so987017pjz.2
        for <iwd@lists.linux.dev>; Fri, 17 Feb 2023 03:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbital-systems.com; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oruUkA0EQjFrzL2ZuXP1QTDoa1S0rOhhiT6wHV0Q9e8=;
        b=gEEY8dZR8jNIllZe5sbNISG3JwFfJLnA+eRTT44Na07UbxRyPE10cPT96saINGPKi9
         U962wHAPolzAf0Zs29GeGmuyETJqhZ5QX6CU6t8PE+QjFsq+EYXOngMBY+txQhhgFx9B
         BlHtkSTekRFCTl4XeYGkiQ/HFPNLDQ4RWsrkC5l1DbdDOGLHdcoIoP0/vjVV1E5H4r9k
         vEOIUNC9EjTOlCw/Ko4poOfyZY73x4dAUHBXqwLjad9C0ZZ1f67RuCLxMCPB2w9tgxrf
         Enh6ABFgzuFb1MON4Y33CtJKVnCeQXthEhqHTZoStyUSB59Ejx1eJhrpUCtO76nGvLEJ
         g+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oruUkA0EQjFrzL2ZuXP1QTDoa1S0rOhhiT6wHV0Q9e8=;
        b=P2hveXfl0qL3FVa2QZllnq46ZQ8M8chSWlNNyf7RPhdC5gx3RBPl/tJRpywhFxL8XP
         R952FFOJl+crKZz/iE4hP7lO4T1WYhcXPWJrkaUjG2ju2XTwA3tpRUaVuyFFnIImpKSP
         Ccqf/Lp14TxHoC2eX/hfl/PzTWhNOzgOB/ISd7KJS78rgvEx1E7pCWd2OkKmxExfTSV3
         siv8ODCcTZtze0s0SDQqjWCg+AecoXzMDcC53X5PpaXRci7DCGwy+UHNfuV2z+OsiTaW
         bQSlqawM2Bp64+erVc2iO+OFcAdYxVWLmMRuV/YouQnxuzKFCJeEE56eDtgC1oxmONXb
         OWCA==
X-Gm-Message-State: AO0yUKVYlbhqr7K1pwcWj7GJZ4Of8tJ+S5kNxx4iMvNjZA8edfLvUOLf
	Rag0667lBHdRBEkIptPC5LpSwaYsMiAAxT2FNc3kOL/6tTgeIg==
X-Google-Smtp-Source: AK7set9gz0HGp6610SAwfvloBraNr85UaeRphtFTxYhmH5cKTa+cN5dkqzTGnbPpEnv2bgtwFMK5M353R66C6axIrz8=
X-Received: by 2002:a17:903:25c3:b0:19a:9834:bb2c with SMTP id
 jc3-20020a17090325c300b0019a9834bb2cmr166674plb.11.1676634072224; Fri, 17 Feb
 2023 03:41:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: =?UTF-8?Q?Joakim_Lotseng=C3=A5rd?= <joakim.l@orbital-systems.com>
Date: Fri, 17 Feb 2023 12:40:46 +0100
Message-ID: <CAELJisw+czjWSgHKNi7w7mkBX80pK=KnC4Nu0GNi9j-fq2n6dg@mail.gmail.com>
Subject: iwctl using readline, and readline is GPL3
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Is there any way to replace or remove readline from the client iwctl.
iwctl is using readline which is licensed (since v6) under GPL3. GPL3
will transfer to iwctl. GPL3 is a problem in embedded devices due to
the GPL3 stating that the software must be reinstallable. That makes
it impossible to have a trusted (signed) filesystem. And a "port" is
needed to be able to re-flashing the device.

Maybe a build option to just remove readline support? It will be
perfectly fine to just have a cmdline support, and no interactive
prompt. Other solutions out there are to use libedit. Or even
noreadline.

Yes, we can remove iwctl entirely, but it is a very nice tool for debugging=
.

Anyone done any modifications to iwd (iwctl) like this already?

Please correct me if my understanding of all these licenses are in any
way wrong. We can't have GPL3 code in our Yocto-based solution for a
small embedded device, due to the reinstall requirement. That would
complicate the product and make it more expensive.

Thank you,
Joakim Lotseng=C3=A5rd.
