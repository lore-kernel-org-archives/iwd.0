Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6431DDF5
	for <iwd@lists.linux.dev>; Thu,  5 Sep 2024 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546403; cv=none; b=Wiwu/GvyzOsQq8JDmjBQkz7NgV64F8hE+80MO9RZKuWyHi7Bx7VdkASUaX5pgEKoLYW3iDEmSKQuU4bOTzIuiwD1aH7bMo7RsHYUaEtVRRg+oLMuKKCh28BtwTcl449zOj95ylJfOi4gN6t/HOFvI3w1FuRSFJtlU6z4xtoklmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546403; c=relaxed/simple;
	bh=PDTqTmB3eRHF03IygIYmDXj5OL1+nuH5oybVkaERZMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0md4EhiDm+4BO5aEwAISk5Bqhz5SQMTiWNb8G2vUBrFv8FPHx1cGIxFnIqMQotc9SKMo3bgMB+o/8IDmEKQbUDiOhbzvtm0AH9Fnp4gnyERr48SbQffEfN1OcHm1N8zMNM9weGUVh7sEEEgAdRvH4z3uDn4dAAM8eNJFC+Hoek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6d49cec2a5dso7925917b3.3
        for <iwd@lists.linux.dev>; Thu, 05 Sep 2024 07:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725546401; x=1726151201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnJ0UASIuicqm488W3Y1dWAqUiAEhZCOqztKDJ15MTk=;
        b=csdD4j2sZ1TB66li/2K34BknvXoVWI6SimB3eB6HuIWVqp0sAHBzItWRKo586tPZRh
         DRWytRo1qODLjtnH29tOnCjP0gyzbVJar2GFSXXYt22YdMTb2hQmVRsFSe4xPD2K3jAJ
         713NWzwoyPTwSN0kvbE5YS+1HL7kYioiArmFYEUww3cZZGJKEp0vNK0TGzGW74AhVxKc
         9Q7UuajIeYWQwCgiVgneUko12d0XBGBnpdRK6siBmaG3HbVYv0loD6xD1w8pCpmtBctq
         IsWDh/Pp7Nv3UgT3CP7fkgSCurOnKDUmBoZfNKwGIKyPmT3G9EWUUjiO1UTuazzYVdEZ
         gYqQ==
X-Gm-Message-State: AOJu0YwOLJU1K165P1oa07/qUuCcYSoj0H4QRzDl5E56bT2gdrlZS5qp
	25BekHILiW02aI+c20uWbWiDafDulFBtur5Ge/eaiX93rYlnd4mYokjhSw==
X-Google-Smtp-Source: AGHT+IHpNUvyLAEHbdghUXFcoL8sQdeWA5fKhea3h7V3JE6BKbJ6qrFmoChuRwF9NCiMqyR+oidK7Q==
X-Received: by 2002:a05:690c:3109:b0:6d3:a447:24c7 with SMTP id 00721157ae682-6d4114808dfmr190295347b3.44.1725546400688;
        Thu, 05 Sep 2024 07:26:40 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d438e169sm28671667b3.61.2024.09.05.07.26.40
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 07:26:40 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so1017001276.2
        for <iwd@lists.linux.dev>; Thu, 05 Sep 2024 07:26:40 -0700 (PDT)
X-Received: by 2002:a05:6902:154c:b0:e11:6348:5d86 with SMTP id
 3f1490d57ef6-e1a79ff65e9mr26087905276.11.1725546400053; Thu, 05 Sep 2024
 07:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_N+Hjt2c8t8hN4VMx79QsQ3hiiE_cwOErg6fKoyHkr67A@mail.gmail.com>
 <ef38aa12-634e-4870-888c-219c961f301c@gmail.com> <b0ef10a2-c30b-4b6c-8370-66f9e0ace7b1@gmail.com>
 <CAG17S_P_MO4_BZYTCp4WDkJ_q4j=0s_s3azCOWrsvqmLD0ravw@mail.gmail.com>
 <de951e97-547f-4c14-841c-267f64b0020b@gmail.com> <CAG17S_Oh_1NS9SUSadAJkMXtJ3s_AjMhnUDSqrKMzEiO69jBPA@mail.gmail.com>
 <cf5ba208-58d9-44e8-bd91-0639ea062d5d@gmail.com> <CADXxVSLa+DF9CRWy0Yin7cShrwauQw0=EC-i+MuGnxVcB+2n3w@mail.gmail.com>
 <5b8e4908-a41b-407c-a767-a3bb9f7ea017@gmail.com>
In-Reply-To: <5b8e4908-a41b-407c-a767-a3bb9f7ea017@gmail.com>
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Thu, 5 Sep 2024 08:26:28 -0600
X-Gmail-Original-Message-ID: <CADXxVSL42J5fzzfmOPOgtY-soDQS3s=RbOL26ThLNs63as+A=Q@mail.gmail.com>
Message-ID: <CADXxVSL42J5fzzfmOPOgtY-soDQS3s=RbOL26ThLNs63as+A=Q@mail.gmail.com>
Subject: Re: Any recent wifi certifications with IWD?
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James
At the time that was the only issue.  Although apparently there are
some new requirements now.

Looking back through my emails it was
SAE-5.2.1 test case.  In the end they claimed the Security R3 MRD v1.3
document required it(6.3.1, 'SAE Hash-to-Element).  Honestly it was
about a month of going back and forth and they did not want to explain
much, just saying it was needed

"
Dear member,
Pls read the subject/objective of this test case and you should be
aware of that the feature of PMK cache is necessary.
Btw, this functionality is very basic and useful. I didn=E2=80=99t see any
other vendors not support this feature ever.
"

I can forward you the Security R3 MRD v1.3 document directly
Bryce

On Wed, Sep 4, 2024 at 12:59=E2=80=AFPM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Bryce,
>
> On 8/30/24 9:37 AM, Bryce Johnson wrote:
> > Hi All,
> > I was wondering if anyone had recent wifi certification experience.
> > We are working on a new product that will get certificated in the next
> > 6-12 months.  Last time (about a year ago), we had to switch back to
> > wpa_supplicant last minute because of one failed test around PMKSA
> > caching. IMO it was a pretty ambiguous test, but couldn't get the wifi
> > alliance to let us skip that test.
> >
> > There was some discussion at the end of this thread:
> > https://lore.kernel.org/all/504042cf-1704-a590-391c-009b500cf505@gmail.=
com/T/
> >
> > We got our testing in last time just before some additional wifi
> > certification requirements.  So there are probably some stricter tests
> > now.
> >
> > If anyone successfully got certification with IWD I'd love to know!
> >
> > Bryce
> >
> Just to remind me, was the only issue you know of PMKSA support? I'm
> having a really hard time finding any actual requirements on the
> wifi-alliance web page. In that thread you had sent some of the
> requirements, how did you get those?
>
> Thanks,
>
> James
>
