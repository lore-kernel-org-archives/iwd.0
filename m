Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0390F2EAEA
	for <iwd@lists.linux.dev>; Fri, 24 Nov 2023 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDiPFW5E"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5cca68f6e01so21835837b3.2
        for <iwd@lists.linux.dev>; Fri, 24 Nov 2023 11:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700853712; x=1701458512; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cg5V6XoyJR8iXQInn9Jk1Wtv5auzAteAYsIyVfPexxg=;
        b=CDiPFW5EE8HG3Zlf9YxXVpb0sslxhb+lacz6akIU5ATQ0NoD/EPWpAGOtMQvvbCAUP
         6u69GH+c/BEkSe7HBM9vG1QW8o98LVeWMTWtVdCQfOivz8LbYt387dyadkpgr8yR+TQX
         MENf91D5pGtT68yOKm9+fktrJSTeVYWXE6F5hLz5dTvre2vUV/g9EynBcE4JdYmCZatd
         QFvDG41/XttpdmOV/iVYdZuLnUeIE2xdY1w3KcXpq7fdOGCn1U9ZAZSMq4ali0W8gOMN
         mxqDX4g8QuiPit7+EE1sIWf00ubOlNHu4mEJDrfg72OhRwOWupia2jDgU6JMbtcxbSam
         fEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700853712; x=1701458512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cg5V6XoyJR8iXQInn9Jk1Wtv5auzAteAYsIyVfPexxg=;
        b=MJhS8zfgGdtTdn0iJYrOPVl+D7GxrBKUk7vSnaRDzymEV/Tv7t09Aa8Tn9GPE4JUS0
         9GGaeqGTW9QvrOAUKZZ2BmzFHLZtsWl0u4XWin+/4bMx3HEhuJG2KaTQiC56Fn+XE2o8
         8gUK9+1zyXt3xBi6NKR7pYi/jt2/lwNLm3HXm8B8q4QBCqkRkRXk8WW5B1xkfZWBXp+A
         7E+B5uTTB/R7nLCzW8hLscTMon0aPmoXRg+YtGOe92OLdxKlxD8ZMhdGp6eXUwG+Yc5r
         vPrdTJDZoH68zRJdCjuS89FJxouxVbyTcV3i+iBki/Hccfx3GfM8Pp1XZaybqHOb0E/t
         nv6w==
X-Gm-Message-State: AOJu0YyUIJqJYMvZFq2WEtcKoHwx6KXmhtobi+pqibnc5nKw3NMSFNj5
	Le9sMGdnLSLPa2o6nfjXLxnkmNhspIf+WcG27xA=
X-Google-Smtp-Source: AGHT+IH6IiSaghNck5nYPE9KE2wfFBVFLxdMg67+KB+4EEZqc+TI/Zc8BOdEnTFsdjFjeeTlW8X5DYw83zZTdxzRCsk=
X-Received: by 2002:a0d:d40f:0:b0:5cc:5ed7:7bb9 with SMTP id
 w15-20020a0dd40f000000b005cc5ed77bb9mr4220338ywd.14.1700853711934; Fri, 24
 Nov 2023 11:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <87fs0ve52l.fsf@toke.dk> <0d1aaf1b-09b3-48c9-82ed-fa3a46cc56b2@gmail.com>
 <87plzzhz4g.fsf@toke.dk> <c3854a08-c529-46e2-81ed-29cd4046de4f@gmail.com> <87jzq7hweq.fsf@toke.dk>
In-Reply-To: <87jzq7hweq.fsf@toke.dk>
From: Rhys Perry <rhysperry111@gmail.com>
Date: Fri, 24 Nov 2023 19:21:25 +0000
Message-ID: <CAGTBY+t8-4wMv9VEBPsno3e94dfZqjDB53bHyNT0mzrj8Byh5g@mail.gmail.com>
Subject: Re: Wrong source MAC for DHCP requests with AddressRandomization=network
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Nov 2023 at 17:51, Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.d=
k> wrote:
>
> Denis Kenzior <denkenz@gmail.com> writes:
>
> > Hi Toke,
> >
> >>
> >> Yup, that resolves the issue so that I can connect. However, this is t=
he
> >> DHCP packets I see when moving between two networks (back and forth):
> >>
> >
> > Excellent.
> >
> >>
> >> 17:49:59.040639 1e:aa:ca:6d:0d:e0 > 92:0a:9a:27:ca:65, ethertype IPv4 =
(0x0800), length 342: 10.42.3.52.68 > 10.42.3.33.67: BOOTP/DHCP, Request fr=
om 1e:aa:ca:6d:0d:e0, length 300
> >
> > Looking at the timestamps, are you sure this isn't a DHCP RELEASE going=
 out to
> > the old network?
>
> Ah, yes, you're right, that's the release - my bad! Didn't realise a
> release was also a "request" type at the top protocol level :)
>
> So in that case, thanks for the quick fix!
>
> -Toke
>

Just gonna tack on the end here that I was also experiencing this
issue - posted about it in the IRC but there was no response. Thanks
for the fix :)
