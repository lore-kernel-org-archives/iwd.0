Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A1127710
	for <iwd@lists.linux.dev>; Wed,  3 May 2023 16:30:19 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso4666873a12.1
        for <iwd@lists.linux.dev>; Wed, 03 May 2023 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683131419; x=1685723419;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWZBRuMrDzfYB1j5CutCWogRNn20kxHq7S5Qhn/FiqI=;
        b=nYum/eoiQOBGFt6BJsEuhUU7AcaPsFG3OPNhFl7hZyQGKJZeKLgzbbpwQfsJT5THaw
         Zn7Jfn3XVjJSoudCcAKGNW+5p7om6A3RF6rB2wk5nZTnpeepIKd5bD+im5FsyKHNcmqY
         51nXMqkwB3YyOPzIIkocXo7ChhZc09BtURosaUHJWlVGlmbNu1kJv6n1p+hY5sBona5V
         zGIl2snor7HVprg2fkZREe8SWcNWqGenLM45AfylRu0Kik3G5pD5/G2jvwwaMi+IUppV
         vkG2RB36nJCUKG6zbWyE3KE+CVXyY5UaQ29tCeNcxGjSuL+FwbH7ijYnn81Thfge3jl/
         vNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131419; x=1685723419;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWZBRuMrDzfYB1j5CutCWogRNn20kxHq7S5Qhn/FiqI=;
        b=O54OA22yO4ysl7sgj2Njxi6s2dAsyyP/u7rDtK65koqMVpLGCHK74CFk9RCivi3QBY
         F+IDHZW+XmOVCI2+Gg3OzwZSp26169roQficf4ZRj/AVRHeXF/xpbAF3OTN1HUO7AXRX
         tAy7dI3kVeLuNsIkXu28MR54qRyCOHpaVdgNmR1o6jFlpx9CE/xtARxdRQxuDe4Gt8xb
         4+WXhGfOlV8ycKeN6niFo6bJXxddDIsbKhWbeKPmz8GR8OJsFaJc0C3M4ILwSmKs0fXp
         Q24WGAZ6ZS3eWklPMd/skhMVablR2CIZfIbVvqRwF/d4TcDPkbd+OtIaYPLr60/lN7sk
         HdBg==
X-Gm-Message-State: AC+VfDzIz6X1Z+6Ic9WDXXC0lc5RV+FZzMXeiMw5yZ6IRgL1q3qdtCP3
	t9MKe0W23qX2gQqiElg8QJsE9ZAR4HKsuIfJy8Rr4KvcnYQ=
X-Google-Smtp-Source: ACHHUZ7Q2OQoZAJyRtk+PW5yIcFM9d+hndDPzdCzFBjDUOpHPOatKAS1nWUN7lZ+4QQeWncjhalIa0c9BkrSkFOJWLQ=
X-Received: by 2002:a17:90b:10d:b0:24e:3752:195b with SMTP id
 p13-20020a17090b010d00b0024e3752195bmr5085101pjz.9.1683131418903; Wed, 03 May
 2023 09:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+iibzC0O-v+Rk+799=QYmzyAZo_3XcN1mfAsM-QtnA8zc6wpw@mail.gmail.com>
 <DE0B5BC4-B2D5-47FF-8D80-8FAEC8A65CA7@holtmann.org> <537606f4-9708-0bad-2144-d4809dfd7548@gmail.com>
 <914A101F-70E4-4FA0-80A9-CF3A28BE61D2@holtmann.org> <b2be8a34-3624-b269-e253-6b76373807e0@gmail.com>
 <CA+iibzAW33xScrgXCqMebr1t5AmpPG6xntsv+8z4cUjc8ih4uQ@mail.gmail.com>
 <CA+iibzB2XA6xuQtMQRH3vcPiRtsb5bdDHRDQN5HNbvu2eQttJA@mail.gmail.com>
 <CA+iibzCNBhsS3sCkuN4cdvWmLDokaVMoVS6r8Q2mcKKx1+mm-g@mail.gmail.com>
 <4fb2f58e-8a05-93fa-de19-d61d9b4320ed@gmail.com> <BD529D19-3091-44FA-8AFE-BE89445D9B13@holtmann.org>
 <2d6dba3b-91f1-4abb-405d-d93fc29e935c@gmail.com>
In-Reply-To: <2d6dba3b-91f1-4abb-405d-d93fc29e935c@gmail.com>
From: daniel antoine <univac55@gmail.com>
Date: Wed, 3 May 2023 18:30:07 +0200
Message-ID: <CA+iibzBN1BqvuNoY8HMVjXxJ_VG3QEpJEOxAYpb4jmkCCu4-Qg@mail.gmail.com>
Subject: Re: commit IWD 8f0420c533ae6a49c4f2803afe32d5922a5236ad build error
To: James Prestwood <prestwoj@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi
version 0.169 was the version of the file /sr/readline.c in the
libedit package that have the corrections for the readline commands;
Now with libedit 20221030-3.1 the version of readline.c is 1.176
I suppose that libedit is at the version 3.1 and the level of patch is
indicated by the date 20221030. When the compilation of IWD was not OK
the level of patch was 20210910. If you go on the libedit site the
only available downloadable version is 20222130-3.1

Best regards

Daniel

Le mer. 3 mai 2023 =C3=A0 15:50, James Prestwood <prestwoj@gmail.com> a =C3=
=A9crit :
>
> Hi Marcel,
>
> I really am not sure. Daniel pointed to the change logs which indicate
> libedit 1.169+, but obviously that isn't the version numbering Debian use=
s.
>
> So maybe its just not possible. At least we have this thread in case
> anyone else encounters this.
>
> Thanks,
> James
>
> On 5/3/23 3:07 AM, Marcel Holtmann wrote:
> > Hi James,
> >
> >>> I have updated libedit to 20221030-3.1 et the compilation off iwd is =
OK now
> >>> may be you have to specify that the level of libedit must be
> >>> 20221030-3.1 to build with libedit instead of readline
> >>> I am sorry for the convenience the problem was on my side I was not a=
t
> >>> the last level of libeditt
> >>
> >> No problem, I ran into the same thing :) Marcel, is there a way to do =
a version check on libedit so configure can detect these unsupported versio=
ns?
> >
> > I can check for version >=3D 3.1 when looking for libedit. Is that enou=
gh?
> >
> > Regards
> >
> > Marcel
> >
