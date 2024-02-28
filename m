Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA51612FC
	for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133083; cv=none; b=FISWGr7yGntfnDqdIRV/AcI8YKrhIOcqNTURCznSxMcrzz7w7dDbV/fMZQSpznDWQuO/93JzAiwsYtwwBeR39KtkY8Wg3qNio5xyVot4iF6eOD+Et4+LMoSCu857cMtoWoK20yAwkH/qFwjmaBACZZHXOmVPSwMGHg826HQEwJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133083; c=relaxed/simple;
	bh=fS3bqknQSAUWHeNazttoKMZMdQkGUXbIgsLKzm+zyXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAhghFxwqsL3x4QiHVSriKceGcDkJIAiNf2TCJzXpgRiUhkC7RG1FtKDVTj8cGA1zDqNeRPEbT+lonNx+l9kuUUTVmL12IMi44+0u5R4ZYEawx/ApiRLTU1SW7/4mWMFFaMEp+P2LTQLAmb2+D0LmI971P0tq8VzMYCNuSLS5AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwGnGKCW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwGnGKCW"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e55101cc56so1320524b3a.2
        for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 07:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709133081; x=1709737881; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5yAw5W0oAzQLCoU1NoxRJtSnIVNJoZH1sYgWIx2eF0=;
        b=OwGnGKCWbUuFBhAZStvHXSpzJ2NAw72K14sXNoFIypwfQUcHKe8fzsdoGhy8v2+w6r
         eO/j0GyrC7oFuiAAlnM8883xUpiA9rWJv64ITIx3KvbrgLFh0UW/BzRsxGkTkNQq8EcR
         ZcFUGn6dgC/qgdHeN3I+Gkmub6Y+mpVuklavvzGSCfkBGWL9aT0z9UatAax/mGCGjKyq
         wEmTQtRRDPAiihSrJTwpwAJGCyv+Ouws8SXB7GtTIONvBs7pe7tWSBUVLi4fzzVmzkRV
         TzXcduvNwPZetwPUuyi1H/Nrfio0tFhSh8uniNpgkU5VrkkPoy7hvQGYexivmiSWTlMd
         KueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709133081; x=1709737881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5yAw5W0oAzQLCoU1NoxRJtSnIVNJoZH1sYgWIx2eF0=;
        b=sGdeVngP5lvfUG3QNZ1c8+AHPgTc8r5txMJIhnTqArtWoYQTqgy//pvZefN/XCzBYu
         R/3ywGdpd97xw1/ppP7pVvB50N+fe6/yCyml7Q0uM1TUIunjsA4csO9g/kOHNlhC5/d4
         XzzGmCaLxI/vBXJz7GdhNzu8K0PZHnxQP91orl8wLeky59zorvIZLnvIIcR24DlAI2mM
         Pc4Tw0yiIiw12MMBCPEprg7a3kN/90NtjSwx+1RgqkAEwbgSE55Gzh4cctLJE2LGsmtn
         D8EfgtVtGqiiAKCnZmLSKAq1dcbc5nbe49V+gC5vOHV29ZTcvu560kUxkCKc3cPUI9Tr
         OKWw==
X-Gm-Message-State: AOJu0Yx8rCJcRZiSO6ssYABT7fsCFSIOQmHcqBozTUOnQ7u16aOBMOR7
	zo0kiHLe3IuWW9ClLh2KksTAwM/Q5OXEkIDlllAhn9DdCJnLxEV0726orC7kvsS74rjESjxmFTI
	4BWadtyvScXfNEsfSyJd8l/1las4=
X-Google-Smtp-Source: AGHT+IGhmR8qHW8fRQyFYhOhjGt2QCTqjju3AyZ3UI4GbZ2elVMSrFh+f3tqXyZ+P9Inn9LIoapXEuH44Akj2Kmzw3k=
X-Received: by 2002:a17:90a:898e:b0:29a:a423:b1bd with SMTP id
 v14-20020a17090a898e00b0029aa423b1bdmr10652164pjn.9.1709133081410; Wed, 28
 Feb 2024 07:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240228124018.334892-1-prestwoj@gmail.com>
In-Reply-To: <20240228124018.334892-1-prestwoj@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Wed, 28 Feb 2024 09:11:10 -0600
Message-ID: <CAG17S_O2k89v3A_DusK8373jcVwxQMD-3bGOYVcasxNj7xsuRw@mail.gmail.com>
Subject: Re: [PATCH] RFC: auto-t: fix netconfig to handle resolvconf values
 out of order
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

James,

Does this work if the system is using systemd-resolved instead of resolvcon=
f?

Keith

On Wed, Feb 28, 2024 at 6:52=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> The slaac_test was one that would occationally fail, but very rarely,
> due to the resolvconf log values appearing in an unexpected order.
>
> This appears to be related to a typo in netconfig-commit which would
> not set netconfig-domains and instead set dns_list. This was fixed
> with a pending patch:
>
> https://lore.kernel.org/iwd/20240227204242.1509980-1-denkenz@gmail.com/T/=
#u
>
> But applying this now leads to testNetconfig failing slaac_test
> 100% of the time.
>
> I'm not familiar enough with resolveconf to know if this test change
> is ok, but based on the test behavior the expected log and disk logs
> are the same, just in the incorrect order. I'm not sure if this the
> log order is deterministic so instead the check now iterates the
> expected log and verifies each value appears once in the resolvconf
> log.
>
> Here is an example of the expected vs disk logs after running the
> test:
>
> Expected:
>
> -a wlan1.dns
> nameserver 192.168.1.2
> nameserver 3ffe:501:ffff:100::10
> nameserver 3ffe:501:ffff:100::50
> -a wlan1.domain
> search test1
> search test2
>
> Resolvconf log:
>
> -a wlan1.domain
> search test1
> search test2
> -a wlan1.dns
> nameserver 192.168.1.2
> nameserver 3ffe:501:ffff:100::10
> nameserver 3ffe:501:ffff:100::50
> ---
>  autotests/testNetconfig/slaac_test.py | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/autotests/testNetconfig/slaac_test.py b/autotests/testNetcon=
fig/slaac_test.py
> index 26ae0e46..5aeb730e 100644
> --- a/autotests/testNetconfig/slaac_test.py
> +++ b/autotests/testNetconfig/slaac_test.py
> @@ -81,14 +81,21 @@ class Test(unittest.TestCase):
>          self.assertEqual(expected_routes6, set(testutil.get_routes6(ifna=
me)))
>
>          rclog =3D open('/tmp/resolvconf.log', 'r')
> -        entries =3D rclog.readlines()
> +        entries =3D [l.strip() for l in rclog.readlines()[-7:]]
>          rclog.close()
> -        expected_rclog =3D ['-a %s.dns\n' % (ifname,), 'nameserver 192.1=
68.1.2\n',
> -                'nameserver 3ffe:501:ffff:100::10\n', 'nameserver 3ffe:5=
01:ffff:100::50\n',
> -                '-a %s.domain\n' % (ifname,), 'search test1\n', 'search =
test2\n']
> -        # Every resolvconf -a run overwrites the previous settings.  Che=
ck the last seven lines
> -        # of our log since we care about the end result here.
> -        self.assertEqual(expected_rclog, entries[-7:])
> +        expected_rclog =3D [
> +            '-a %s.dns' % (ifname,),
> +            'nameserver 192.168.1.2',
> +            'nameserver 3ffe:501:ffff:100::10',
> +            'nameserver 3ffe:501:ffff:100::50',
> +            '-a %s.domain' % (ifname,),
> +            'search test1',
> +            'search test2'
> +        ]
> +
> +        for line in expected_rclog:
> +            self.assertIn(line, entries)
> +            expected_rclog.remove(line)
>
>          device.disconnect()
>          condition =3D 'not obj.connected'
> --
> 2.34.1
>
>
