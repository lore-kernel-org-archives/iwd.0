Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0923B82499
	for <iwd@lists.linux.dev>; Fri,  6 Sep 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649201; cv=none; b=kmIRmXTmLP+haGrh/J1kJZBUmQzNcbvgf/0tAP3Yey1NGopSS2NDcKP19eZMk9hryRD6/vGXtO75p34WMN2ehctSKwXOWRc4pkxvqCPfTkxzLQpSDjD+axEzHE/6Pw9Ah7l/drBz3XBcEhw0dUOU+Jbjod/375gZGx1xPDcYsYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649201; c=relaxed/simple;
	bh=0/xmzm+r4U4t2F15lwZiv6Em3Rd5sLfBtJkUyQRvnV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a5f/sw2JT2R0nyMagM8RzoYHAGT1XxOu5IutXqF4BwakjvG7myL3QQUfPA6Ztr4kiXqJSNBYPOCtGLMBaTL2OsloU9BKoBPI4s/eRUvWvuI6jH+q+mnKrs7pq1A3SjEiNO5MPrTUQu/RTwErjTfdJP36SOIBM72mhrOux/xWy/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FduwvAwL; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FduwvAwL"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e0047fcb3aso1874881b6e.0
        for <iwd@lists.linux.dev>; Fri, 06 Sep 2024 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725649199; x=1726253999; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8IVS+gN5lRpPoHUWjjkz6bcMiRDO+jthkaFrEl2KJ4Q=;
        b=FduwvAwLu/T62XlqC/zW2HN84uhcyJdAd8sj7xl1pMsv3ZaSdZzukIZB1nv9N9qFHW
         V0aMwJ1U25dYHCV0redyhCY41gjWvq1AFDuFWoTuIJ6RR8R8/J9PI2KecbaPoOIg5evH
         TTMCk3n+qksKhma14i/ZllN7mGN99RSvBb4d5waDgY40ZGeBi3uUC++XvG41zESQyBGO
         gWhYriq7EMXdQogZIYP2i0ilH8BiydVhykQ3trIYGVvRkQbKjQzWUiKEud0kXvzFnA2y
         Aq7e41VxvfZ7KDXmOsRThQreVJ1bNouSgaAt2tXZ9vIYv8gGvrimSlldCjsvw1yWJWNz
         Rx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725649199; x=1726253999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IVS+gN5lRpPoHUWjjkz6bcMiRDO+jthkaFrEl2KJ4Q=;
        b=ot3L1AwCENLiUj9xFpEAkuKkD02euS8lHYH2ACvXRqqTrlr5ll9nK4O0Y55P/NmWLF
         Ua+t6s6OHmSrLe/F60+PhgrKoaVrK0dejv+Pw8brJWSsIkDgYMbS8sZtAg/jPe545dn1
         ttmYHk1JzBFPaCHGCe/ZGq3VK5Z7F+yQkFFUQfSqioJYOJRZ6IGV1+bSupQGvkoRR37A
         Tuv0Pm7aSxxSwPk7wKA8Ki9GYPfxLDdHbnin+GxEUbzO4PSD6E7N7QknXEHDO32CQTaH
         uWazEz/EsSpC3b+ttnhbaASNgdxwJd8UBSh97DnT/4E+9rMxAmCqPkZ51QtXE7WDNPyc
         wzsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuTrZ7ecUt5L56F6xMaBgu8Aq2LqmRSLK0RZWwyjjUjXl1SXaJBh1cNVqq19Ur5WU1iGk=@lists.linux.dev
X-Gm-Message-State: AOJu0YyYu2V5Dhu48XGghdMeSLz5N3cUCCauAkKTcn2N/66mBort36NG
	7J9p1w+Z33bdgjNXDlwWU4fkXtBsprvVFixxmpgaFNDPuj/YMF6C
X-Google-Smtp-Source: AGHT+IHElJ4NzE04+LvsrA4hITQg5Jbe40Zr/vgZKhK+UuA6TNWgQ4ZeSuEL87JUmfRI2nqhjm8bmA==
X-Received: by 2002:a05:6808:1a2a:b0:3e0:34f0:8ec6 with SMTP id 5614622812f47-3e034f09175mr653614b6e.3.1725649199006;
        Fri, 06 Sep 2024 11:59:59 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3df117d7b40sm3889029b6e.26.2024.09.06.11.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 11:59:58 -0700 (PDT)
Message-ID: <3e8ad720-0786-49d7-b7be-1bd862d794ef@gmail.com>
Date: Fri, 6 Sep 2024 13:59:57 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dpp: use peer_addr for pkex exchange request
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240906150522.586887-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240906150522.586887-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/6/24 10:05 AM, James Prestwood wrote:
> This was hard coded to broadcast and missed in the initial changes
> to support starting PKEX to a specific peer.
> ---
>   src/dpp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Regards,
-Denis

