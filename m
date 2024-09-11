Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086F1946F
	for <iwd@lists.linux.dev>; Wed, 11 Sep 2024 00:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726015350; cv=none; b=sMIMMBg8z+4Ftv6OZ7wef+JnN9d2IXQislXHyoAznGvUGM2al9XKdDu+1wZc3immEOEh6Tv000Laoy0NtgRaVBzEkA8GDEY397ZIJRCNoHapaek/IDXpvElCy7+b7gLKBNOupB2Ozs7wMFZmUdOFOlGz8FO4Y0F64f74jfOkX2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726015350; c=relaxed/simple;
	bh=Jki5mnDtra0Ea6dlFlXJM/orQCftNhG45VLnP/xteYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VFVzgEQwNjDQKmGHbAMfER1iamRlZwup21VdS9C5SMepwhMjAWKoewq+BmTRMrhhiVvoChCG/D6R+z33TP4lkgP9mBqL9X47sYj37oc6bqxsm0nOAI5DhfhAKfKWDMxjdde71xoVBKKoGA9mHRZfVrZWEkrNUk6jc7qXsC4h9a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICIQZ2NM; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICIQZ2NM"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e033e37bc9so2292536b6e.0
        for <iwd@lists.linux.dev>; Tue, 10 Sep 2024 17:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726015348; x=1726620148; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L0EJ9KibGOwsRZ4G7J01Dqavu3bEDOpCitc78f2CiOk=;
        b=ICIQZ2NMpCxqSKnFiMO6zpXyoVfjzdHFxBYfoNGCGmY560QrOy23T40DDmnjpBnJ3g
         jW/ViLA+aKahp2u//5ISInNPgqLZdzMY2kSAABQdlEYLiOOYsGEtmFqVY54AJjobNf9L
         FN1vNzqTdXTY9dtJvxMY4qeYudNu7VsgiCmD5kw0R8KhYsSbdgPeQE6Wuad4cxg0Nt1+
         YiCegpTWwjlKT/iTbVyCCilqpEF0yD1uHUk178Wgq8CdCXCavvlKhbbzerkP6Fcmkayw
         kkyBgV+SH5S9jJScoT/Lt1YUv/sk3BNWYsb7jopf9xeEvqHW5GCyV9FqnRIbNZMWQOjy
         CWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726015348; x=1726620148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0EJ9KibGOwsRZ4G7J01Dqavu3bEDOpCitc78f2CiOk=;
        b=B/4X8JZ1Wbm3nWfJECSenKTK1gW0lJ/5UUgi5lj2fWDvOUhJhufakIEmsL0LBi4cAS
         psUHOatySv1hOytnUJIgqeclrD6LmkjlFDWMPpELHEKVOylGHvCTV7B5WijXvN+7rv7N
         eCWcPDGz+n19DYq0J7DwKzfl/VD42t3wUmZ3IeinaB67+8I1/e6K3gGXV9G9pr3HEHyO
         DxiU73oP5Jr4GS9fIN3EYtAhRBolmN4uiRro35gZHb0Wrcd9FHyNTQfyROSDQcrVhUl1
         UVgoobOKC/EkRVF0R1jsyfrGGxLQHXeFYzZKToK/OPVVvAllFk4uDG3FHy1MoLlvZl2Q
         D5nw==
X-Forwarded-Encrypted: i=1; AJvYcCXg/8RMvzG6hdcpoFljjqzjdOAYC0GKbc3WR1zGwzWgyyltFsjp2mj8kAMWdFGjSPUC0TM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4WO6qEtAuJGAjF0oCIBEl2XxAOvILT3gG9IJuUw/ZXBAwlw3x
	4lZ1LyV0stcFw1Viv0duYk96j/a6gxflqRjH2wNxIgdNOlZz3Fq3
X-Google-Smtp-Source: AGHT+IHtmOmyJ3+qXxpg9qrk0T22qL77ttaoFxkfRXkn9w+Wr4NIZ9NrtqcaDLP4IgNjfH3qezfi8A==
X-Received: by 2002:a05:6808:654c:b0:3e0:45fa:e323 with SMTP id 5614622812f47-3e045fae590mr5712177b6e.6.1726015347638;
        Tue, 10 Sep 2024 17:42:27 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3e067998257sm267551b6e.5.2024.09.10.17.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 17:42:27 -0700 (PDT)
Message-ID: <964b6536-cd88-4ed3-bb89-9f9f745e718f@gmail.com>
Date: Tue, 10 Sep 2024 19:42:26 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: fix crash if affinities watch gets removed
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240910184750.126488-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240910184750.126488-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/10/24 1:47 PM, James Prestwood wrote:
> If the affinity watch is removed by setting an empty list the
> disconnect callback won't be called which was the only place
> the watch ID was cleared. This resulted in the next SetProperty call
> to think a watch existed, and attempt to compare the sender address
> which would be NULL.
> 
> The watch ID should be cleared inside the destroy callback, not
> the disconnect callback.
> ---
>   src/station.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

applied, thanks.

Regards,
-Denis

