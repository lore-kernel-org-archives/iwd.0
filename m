Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5DB1A00D1
	for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572954; cv=none; b=rPYQxSQbaL6+yldYgsEpYq1mIbJOlSX9jSsKu/EhLkyJeXhdlVmYyS0UYr7p8zaeF71eXCYUeG4s6XlqGEmYRzgNXX7uHnX9k21mpiu8R5OxfryypT8FV67iKev9VThfGPl8jn4zw25rU4dg7SMQu4rt/DZEnd4zzhD5rUqStZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572954; c=relaxed/simple;
	bh=4pUf4k7e3hG7H0k0CCcEz2FRiZMLsTl4JjTbSJbEhMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SThn1ENQJT66NrPJgsemv3n+NyZRayHHpPFjvxhuZmcI8wShr8KxqX+z6ZpUHYZqoriBH7ge3rZluj/zNUOT8GPKAOBaSRg7St8OwV/uKz9lzKSrz6Sho2R6WJBtpZcq9xjTonhofCa7RGRxoU2t/7411pK05OZb4fYq9YLNqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxaehoYk; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxaehoYk"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so9848898a12.1
        for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 04:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740572951; x=1741177751; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pUf4k7e3hG7H0k0CCcEz2FRiZMLsTl4JjTbSJbEhMU=;
        b=YxaehoYktu9FQT4j7xShpGr5brABSL7zhwCnDusVcZKE/J+97gIUhZ8HmLSPsJZEFz
         O9X3kVpadlxuD8AYW2btfd2IQCbnuXJ6jvYGa44I2yD5YYluaWBCpiolABKmTxIuLr6w
         w6XOC/W9pM9aY6P+p0ViFu3k24A9F7xDktQBklnCK1UDFbcAL6/mOu+7Z0zQ+usuoWHT
         0qONDTbbgzP4iFar3WZa+IiczWRqcaemXhEeXu4V+odv2dpfX8+xqFsKXlir0bl8FEf8
         C4TyCggKgxBT/ZfGVA9CuB6GiORtQ1pqwu880mJC62g7PI9r8YYuClj2+orM9IZV5YJV
         oKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740572951; x=1741177751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pUf4k7e3hG7H0k0CCcEz2FRiZMLsTl4JjTbSJbEhMU=;
        b=INGn4GhQ17msAKYpqykWkD494ljJa7DBqJdNHikQ0BUzJRLUKyT6FcMSNC+ClO82Wf
         ikFsRmnYldmGXcOoaA+vnsxEEY9Y0iFgsH0ybyv4JhqdvkJUpfOVtHUmdKcPulBxWH+0
         i6KIXAH6pw4ZmEtDGjIoz48hF9WV5Lk5jZNlfFEnxp275ac5uBwxZZS1r2pfkzOBf3tk
         iw1g3QRqSgQX+pnHlzEx13sQp7SBLkL5SjeoXcdzzvlLrvIKQf8UEx5lWosuK7HTYsiS
         XUJcgbmrmzZ+nPXLiG7zRxD+EWaSFHbCeoSVvaON4iuX+otn/ujari19xT+psmLv6/Oq
         zncQ==
X-Gm-Message-State: AOJu0YxY8L68tGYbobTtw8QToBdWFB2S3amx2Oxz1sPgk+p7Q/KvOhBa
	lF2dOeZ1IN0y3xIrMgHtLhOLx9v1Np2j6dLEsPHIMSp8B6XR+IVJp5C4FCRJVXJ7xdk1QAaspTJ
	ABUiuyz6vqfB5Tv2I8AIvOGIQrlzASg==
X-Gm-Gg: ASbGncsuvGNAyoRO7llTC76Nxmg25pWE4r4wehQBe2PenR/ep+oq5g/TdmTs7eIBLre
	9piw0bhtQnpVc0Xr+M8FveFm1EB1fEmAky0Kek1UZKLMDc2vG0X1PqZ+v+vZGGYVJDywdDjWXjz
	HadEuqP4qy
X-Google-Smtp-Source: AGHT+IFBeizV315+pibRl8+JSscdQuCkZYJL1HNxk0/Yj84luy96h27hRL7NIDuGWgIB5eD3Pe5KYnteXzDlyEpmG1M=
X-Received: by 2002:a05:6402:3893:b0:5e0:5feb:57d5 with SMTP id
 4fb4d7f45d1cf-5e4a0e2b159mr3908748a12.32.1740572951312; Wed, 26 Feb 2025
 04:29:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADs2FCEpXNpdrVOjiRN6i5WG8=HayYRqQ5P-L36dj=zLyYh3ZA@mail.gmail.com>
 <adedcace-ed93-4fff-9927-e58383489abe@gmail.com>
In-Reply-To: <adedcace-ed93-4fff-9927-e58383489abe@gmail.com>
From: =?UTF-8?Q?Frederik_Br=C3=A6ndstrup?= <frederikbraendstrup@gmail.com>
Date: Wed, 26 Feb 2025 13:29:00 +0100
X-Gm-Features: AQ5f1JodX0jwQjci1WQABmiGf-kreZBoAwMKdvTBJnTu9CG_ayIVU93dAyjdB6k
Message-ID: <CADs2FCFx4Ts5zeftNLshqSOKzQJ057ViVG5od8Luj9TorOt9Cw@mail.gmail.com>
Subject: Re: EAP-TLS support in AP mode
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello James

Thanks for the clarification. Is it something that's planned, or would
you consider taking contributions?

Best regards
Frede B.

On Wed, Feb 26, 2025 at 1:08=E2=80=AFPM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Frederik,
>
> On 2/26/25 3:49 AM, Frederik Br=C3=A6ndstrup wrote:
> > Hello
> >
> > I'm working on a project and would like to know if there's any
> > existing, or planned, support for EAP-TLS in iwd. I haven't been able
> > to find any info in the wiki regarding this, as the only page I've
> > found is https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/ap_mode=
.html
> > which only mentions basic WPAPSK
> At the moment no, AP mode in IWD is PSK only.
> > Best regards
> > Frede B.
> >
