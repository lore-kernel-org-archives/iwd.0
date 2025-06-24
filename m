Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A381A8F60
	for <iwd@lists.linux.dev>; Tue, 24 Jun 2025 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750785680; cv=none; b=RMjTlgUdsT1/lrWNLlqVkXK2stRD0sYLmCTLjMVd7PMV7M5cbrUDT0GV0oCVWlHPG1bPxE3Ga6W4CPrMP69btuHXU+enwfT1D8e6SWl5xtQw+55ZYNp+LhaWB5Z0S7WBA3libR3y3vdKyayLZTwEAA1vFB4kJ0kmj26ytS79Bbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750785680; c=relaxed/simple;
	bh=NYNPmgHLp4H3gowblSrsGdMV20pp2VkgZwxkpbhxUDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkK1mLSvGVigRCGX5EaFnVJP1yWtxgatjW3IuV9AQXlsZAr64tSTmnPFABLB2CnVQUi4V9w/l6acxAnL73hiEm/Uaiem1AIR7ULFsBMjcoWmlw9O4SfNplqlWYXUFeVQE0O27xVyIKcglpb301KPpjITGR3tRNmOdtHnGUuGPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyMoX6BB; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyMoX6BB"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70f147b5a52so42882647b3.3
        for <iwd@lists.linux.dev>; Tue, 24 Jun 2025 10:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750785677; x=1751390477; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYNPmgHLp4H3gowblSrsGdMV20pp2VkgZwxkpbhxUDM=;
        b=QyMoX6BB4k5r18A+MX8YxF1fDIUaxM1uREwqY1uYLE2iL68BuYS46ZQSyCOe+nHgj2
         HqdD5ODW3jqoAL7skF9PfHbhaNU0aLK+MHA1t2Wu9dixGWUWn1PfStsuYIrRiuZUNinc
         GjuNAsswwe8xgDRlftSv8YtGDC5UdDpKuRqAejl6xi/nrX1T0QvQC701c+S18n788XVs
         G+vZ7ioAKl9IaRqaJ1rmWUw4AXf+1k+gWxE+qKhRCrJ6o+URqcX6YVncU/82g0f/Y4nd
         k1L2vt9EtEcJ5sSvCetxNLj0mmH80AtEAqurKrT4Mc/vwlwokaguJRmqbMvppafENBiO
         Oifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750785677; x=1751390477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYNPmgHLp4H3gowblSrsGdMV20pp2VkgZwxkpbhxUDM=;
        b=jung2r5zbVc4gSn8tntKW6LoHrmq44Fm1/Rd0OFMQFu1H0gTrrRVkocKsftzBYWBXe
         GoOU4J/qHnSfocY/hf+EKTjRErUwbQx/P2fRrkW7dOU1QfyE43H95//HGrxiQYDSYYIB
         d+DOwguAcKX+0vYAl6couFv0JCuylwsDlAQHDe5xBRMfezPwJtTzDPEFNUyvmYj1Oerj
         D+VTXn5DFYJnLL/mYJCgfyswR9z7tGihg3o3P4LzO1Rk65cKdxtZcNG8RY0IeJ+6ruCo
         zJZqelcW4taELjjqLC+1ongOycRrjhH07oSqCjAxrLFvF8TSv/fUzpaJYRqvB3PRIeWE
         GpQg==
X-Forwarded-Encrypted: i=1; AJvYcCVpRzUdfRxoJv1Y6jMAVOyzT8Cxn3M7wypKeUxlONdRVJRzxsH2kZ8WpJWkbnjFviE1QI4=@lists.linux.dev
X-Gm-Message-State: AOJu0YzSmog8sGT3eIyBG+j0cZGYnYuumrK13Owq9DMfsyGxEpq2XYuT
	CI0G/Ix3C3AQ/qkz35R4twpPs92RvE6ZZ7+5GczjwCsVjuB2Rs94mnciU3JwcrNWeFeCb6jGKNx
	jXATGJYs8TIm0b/O0muVzVMsH9EVpDWg6/83hfBc=
X-Gm-Gg: ASbGncu3XIF6QrzKwPW0VOOO8USbLgq+f3dKsDUFw9APtVWwwTvpMhQJWJaa/8KIAVF
	J/SYbKb6A9qIV8cu4inFgxiSO1RO0dyZbwVfyBQ9eDDgi/Xav1pt4Up2EiS9MATMjQU4fKZwEpI
	oRVFvcKXh2sPgRuBlaJMM939r5pYuy29jwYZtXzOIhQ7WhjQ==
X-Google-Smtp-Source: AGHT+IG8uf+XFiI03Fb1JtZ3Vr60LlNJ6/g6wBJdP5XaxIyTI4tQWrO/XS7eb4VyemxDRgJnRLSlNq75P06GH2ll8Dw=
X-Received: by 2002:a05:690c:3812:b0:6f7:ae31:fdf with SMTP id
 00721157ae682-712c63b2eaemr250432097b3.12.1750785677575; Tue, 24 Jun 2025
 10:21:17 -0700 (PDT)
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
 <CAG17S_PcYOFqbfKPnaNUsQ0AsJzWGRgGDRYrq9SgewUskqck_w@mail.gmail.com> <197652ee6b0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <197652ee6b0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Tue, 24 Jun 2025 12:21:06 -0500
X-Gm-Features: AX0GCFvRaAeQwj8Uvq8-7NGBDaZXkhEm79zgIwmWgPsVUGSDkAZU2H_73e944X8
Message-ID: <CAG17S_NuBvCbNd_FKUTP3SpShExiE4Z1Bx+zDPkfTe_ht3o86Q@mail.gmail.com>
Subject: Re: brcmfmac disconnects when iwd scans
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev, 
	James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 12:27=E2=80=AFPM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On June 12, 2025 6:51:29 PM KeithG <ys3al35l@gmail.com> wrote:
>
> > ...
> >
> > On Thu, Jun 12, 2025 at 9:37=E2=80=AFAM Arend Van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >>
> >> On June 12, 2025 3:51:34 PM KeithG <ys3al35l@gmail.com> wrote:
> >>
> >>> Arend,
> >>>
> >>> I am still seeing this:
> >>> wpa_supplicant[431]: wlan0: Failed to initiate sched scan
> >>>
> >>> I tried the brcmfmac options listed above and got no change? Still
> >>> getting this every 6 seconds in the log.
> >>> Did I get the command in the modprobe conf wrong?
> >>
> >> Maybe. You could try to merge the two value so one line with 0x200002.
> >> Could be that wpa_supplicant determines support for scheduled scan in =
an
> >> unexpected way. Have not looked at the wpa_supplicant code for that.
<snip>
>
> Right. Scheduled scan is a different API compared to the normal scan. It
> allows userspace to say "scan periodically and let me know when you see a=
ny
> of the ssids I am interested in" to the driver/firmware and go take a nap=
.
>
> If I remember correctly wpa_supplicant does a couple of normal scans and
> when it doesn't see the ssids in its config file, it switches to using th=
e
> scheduled scan api.
>
> Regards,
> Arend
>
OK, I get it.

Could it be that I an running hostapd at the same time that is the
cause of these 'Failed to initiate sched scan' messages in the log?
I am running this as systemd wpa_supplicant@wlan0 and am using
systemd-networkd to manage the IPv4/v6 (not Network-Manager)

This log shows what happens when it is connected via hostapd to my
laptop and then I turn on my iPhone hotspot which is 'known' in the
wpa_supplicant@wlan0.conf:

Jun 24 11:58:50 pi4 wpa_supplicant[423]: wlan0: Failed to initiate sched sc=
an
Jun 24 11:58:56 pi4 wpa_supplicant[423]: wlan0: Failed to initiate sched sc=
an
Jun 24 11:59:03 pi4 wpa_supplicant[423]: wlan0: Failed to initiate sched sc=
an
Jun 24 11:59:09 pi4 wpa_supplicant[423]: wlan0: Trying to associate
with 36:b7:9b:9b:cc:c0 (SSID=3D'BatPhone' freq=3D5745 MHz)
Jun 24 11:59:09 pi4 hostapd[5315]: ap0: STA ae:00:2d:31:28:7f IEEE
802.11: disassociated
Jun 24 11:59:09 pi4 systemd-networkd[184]: wlan0: Connected WiFi
access point: BatPhone (36:b7:9b:9b:cc:c0)
Jun 24 11:59:09 pi4 wpa_supplicant[423]: wlan0: Associated with
36:b7:9b:9b:cc:c0
Jun 24 11:59:09 pi4 wpa_supplicant[423]: wlan0:
CTRL-EVENT-SUBNET-STATUS-UPDATE status=3D0
Jun 24 11:59:09 pi4 wpa_supplicant[423]: wlan0:
CTRL-EVENT-REGDOM-CHANGE init=3DCOUNTRY_IE type=3DCOUNTRY alpha2=3DUS
Jun 24 11:59:09 pi4 wpa_supplicant[423]: wlan0: WPA: Key negotiation
completed with 36:b7:9b:9b:cc:c0 [PTK=3DCCMP GTK=3DCCMP]
Jun 24 11:59:09 pi4 wpa_supplicant[423]: wlan0: CTRL-EVENT-CONNECTED -
Connection to 36:b7:9b:9b:cc:c0 completed [id=3D0 id_str=3D]
Jun 24 11:59:09 pi4 systemd-networkd[184]: wlan0: Gained carrier
Jun 24 11:59:10 pi4 hostapd[5315]: ap0: STA ae:00:2d:31:28:7f IEEE
802.11: associated
Jun 24 11:59:10 pi4 hostapd[5315]: ap0: STA ae:00:2d:31:28:7f RADIUS:
starting accounting session C040C6E0561E8E1E
Jun 24 11:59:10 pi4 hostapd[5315]: ap0: STA ae:00:2d:31:28:7f WPA:
pairwise key handshake completed (RSN)
Jun 24 11:59:10 pi4 systemd-networkd[184]: wlan0: DHCPv4 address
172.20.10.2/28, gateway 172.20.10.1 acquired from 172.20.10.1
Jun 24 11:59:36 pi4 systemd-networkd[184]: wlan0: Gained IPv6LL

I did not initiate a scan, manually, but when I turned on the hotspot,
it immediately connected. As soon as I turn off the hotspot, I get the
'Failed to initiate sched scan' every 6 or so seconds, again.

Keith
