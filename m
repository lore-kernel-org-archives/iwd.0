Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D051401C
	for <iwd@lists.linux.dev>; Sat, 28 Jun 2025 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751126264; cv=none; b=QJU1i1fVz/Qafhy63bGO+FT3vemhDId1YdeTd47pF7KbQCU5zoTv2twLuvDRUs/cwC4ZcoqKs1vI5dU8Dnkv7peGz8ghYaikfOZqLrrhJz5PQVSQAsogZsPoH9fFTBy6YBrJwMJV8uC535f7lTEZxFlkESm7/WQXcwssbzPdTPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751126264; c=relaxed/simple;
	bh=ogvrsB4N/pvktoPshwgWFnJlrj7pMEzqaktCntKinQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rj7mILqX+0fQEizNIYafi4CpLOo83nN1bOQ+1tDaUeYqeDmkmhHWTXQ1ig+KNDDQRGBQlY75z0Ns1oDrvOZXiTIXGObK2fXZlm4GAxGUjbHTXvkaFKgmG0MD0NVnH+Ngy1/r3yoZ6WC5C3j6Dqy+esigu2phgiZ1kS4gigoVueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYchDb1c; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYchDb1c"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e82278e3889so1929105276.2
        for <iwd@lists.linux.dev>; Sat, 28 Jun 2025 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751126261; x=1751731061; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lH+HFlXDx4Rv9lnbHTAKOtf/7vEO4d9wN49VGROIXKA=;
        b=MYchDb1c0QgdftsjJZ/vHMEVFInNVzg2pC5McTA38JD9NMH/o+P0jdKc5TCDEGU7ZI
         8TZOOGfexUiTY8GzsrADWsdweP6kcyDVCgi4YMmOn6yaXT9FCjShhCpC6diuxyshN6zr
         fbKf16ZOdUsWBRT+fFHsVEAoGPzINAsP7FvE9JFsAAQ9E5axdVzoV9a4sFTakqFcW4xq
         UccgXFUI1GO5H5NbpuKHZsFcSGfcwneZqh0ZK+kCLD9VkNCNzTPyJGrgk/LQTsasVNoq
         ufk5cJ7QP+hwVLSwipxgRN+I/S720RP/MAPuWxAIEdMlyozk7lcQRuXkGs8iPN2+EKFW
         YG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751126261; x=1751731061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lH+HFlXDx4Rv9lnbHTAKOtf/7vEO4d9wN49VGROIXKA=;
        b=BUHp3BcnIFiCmha5CEZpS3l4NuO2YEa9LjjYE05vV/WxRwdwNiUGKI5wz6XOlmPfgT
         RvLlM+r6H5QDW3SYzqE/Fv3bElQkFUlbphbJSRm/5jbPJYMJBn02eUFhXQ6KFvMJN9nz
         WgsTvf5Kr+pKjl2vpEbdWgPpfow7FaKfZx7CpvuwEZZaFJDGrQC+xXkBeOE83bppqR8c
         PlTzlbFJ/6yAb85jUCK67+7dM14otvU7lxQyeEU3s+v+HvneybkjL7sw+cevfMALx6xK
         +ARIm3X7RPpCtdvTb5NVTh71q16CQLcLZugx5YSPBUp01iZRIOvmvCQeXphFull+Xlw3
         FksQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+N4H9sqUUYBInUOod2owLLVwHHPloUh1z+JmzzUUF0qkKpSMjygUEYOtfHqFGWuqZvXQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw98qdiIPAfaouG0c90fEcW604pdPMa/UZKoyzvIUvg2dMcObzN
	TVBOpENiW1PjC26qe1IeJRzLjA0WBlNl7JFuFHO1KwzIXANvpvexOm5SZq4447ePd/UE3Z9fu1k
	DidxHB0sQPFQIUZ5eqEZQJ3k+9vRjB94=
X-Gm-Gg: ASbGncvDZ4TAbD9qOC06rkNrr2HzOe3R3pYxiztCTtF2om6M7+r+zaqfqV87an5dsfF
	cN4nEKpDMldMnHOhybGQMsVENRbLSNOn1QPpPzPV/KxQnmbYk1NyZEqVUN0K8GofY30VfG7b8eT
	dLRgS0e0PtQaxTId21bzl+GuMuP4CIvA2qJvs9IODQbF2IzXIbmmNOtE0=
X-Google-Smtp-Source: AGHT+IExaNA+Byjgu1iXKjnqseB4vWJhDeqkx8vj9U/hIJpdYfB5ZLfTeZ6Mwib5B2cn4NtqJ18QAqMNmCLEnv6Oldo=
X-Received: by 2002:a05:690c:6c0b:b0:70e:7638:a3a9 with SMTP id
 00721157ae682-7151719250dmr113323077b3.18.1751126261384; Sat, 28 Jun 2025
 08:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_M4_+CR1uSsajyvHBjig6cfCuxegipnHREhk1sXjSyOsA@mail.gmail.com>
 <a0dcf03d-3bd3-43e5-9532-5a565d20930f@gmail.com> <CAG17S_MKZXf3vC0zgaK_MUrA1nqRzhGcPGUho873KU3jYVShXw@mail.gmail.com>
 <45bc2f1b-b037-4784-a2a9-7732a82b7391@gmail.com> <CAG17S_MqLBQV6ktjbWsoAv0e+2A0dnNN5+X7Pf+b-qDP3mrL1Q@mail.gmail.com>
 <19691dcb210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_MX3S9=EmiHBae8WsRnmsUGBJ5h4d8kCmgdxYZ2Zaeh8Q@mail.gmail.com>
 <1fb12821-1707-4478-941b-9fbc007c4e9a@broadcom.com> <CAG17S_M9_-TG4YnHAwx2+O2bJ6sbEE75X=V0y4Pbxy222O3ZJg@mail.gmail.com>
 <CAG17S_Njkt7rFTk4Tn-KnLVS8kzA61KJGyWgNQ9kqx5M=s7DnA@mail.gmail.com>
 <38be0ddf-50ff-4ef9-bd98-748ffcfed2e1@broadcom.com> <CAG17S_NCAmDPa+jK=OPdF18H8Yuuio3czytaa2q5hMSJiKO9bw@mail.gmail.com>
 <CAG17S_MbUsp6Nu=idnk0p9sQLRJWg=G8oaE1X2kdjwZ_uH4KAA@mail.gmail.com>
 <CAG17S_PxYNxLpAMzXOuS6riv46G22zpOM0rT0D7Xp-usbWyo+A@mail.gmail.com>
 <196b5fd2b70.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_PzWmDmFekBgtBj7VHPt-g2qU0+LSa9WzYi75aNR5Mb_g@mail.gmail.com>
 <CAG17S_NMk44gBa2B=xNyjhXVJuaeYVn-+T9u_8fid+r7k--56A@mail.gmail.com>
 <197649346d8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_PcYOFqbfKPnaNUsQ0AsJzWGRgGDRYrq9SgewUskqck_w@mail.gmail.com>
 <197652ee6b0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <CAG17S_NuBvCbNd_FKUTP3SpShExiE4Z1Bx+zDPkfTe_ht3o86Q@mail.gmail.com>
In-Reply-To: <CAG17S_NuBvCbNd_FKUTP3SpShExiE4Z1Bx+zDPkfTe_ht3o86Q@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 28 Jun 2025 10:57:30 -0500
X-Gm-Features: Ac12FXy4B16tIMqpbO9GWxm878leyceRfHsjH3EHEP-3y64suVMZ2ziSHhHhgM8
Message-ID: <CAG17S_Nb9bsySbRO1=DDZdBp+jjNf=f55wZFYK-SgsdSTdKSjw@mail.gmail.com>
Subject: Re: brcmfmac disconnects when iwd scans
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev, 
	James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Arend,

Do not know if this is correct, but I noticed a difference between how
wpa_supplicant@.service versus wpa_supplicant.service calls
wpa_supplicant.
in the @ version, it is called like this:
ExecStart=/sbin/wpa_supplicant -c/etc/wpa_supplicant/wpa_supplicant-%I.conf -i%I

whereas the normal wpa_supplicant is called like this:
ExecStart=/sbin/wpa_supplicant -u -s -O "DIR=/run/wpa_supplicant GROUP=netdev"

I edited my wpa_supplicant.service to be:
ExecStart=/sbin/wpa_supplicant  -u -s -O "DIR=/run/wpa_supplicant
GROUP=netdev" -c /etc/wpa_supplicant/wpa_supplicant.conf -i wlan0

and now it seems to run correctly and I no longer get the "Failed to
initiate sched scan" in the log.
If I do not have this proper or if there may be a 'better way' let me
know, but now it seems to work.

Keith
