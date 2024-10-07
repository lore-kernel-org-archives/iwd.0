Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605211DD54A
	for <iwd@lists.linux.dev>; Mon,  7 Oct 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325617; cv=none; b=YxWNhtAnrwFlrkpGOW0k8/3ptyxJmhLjH13NUjABDsceECkP8nOJ9x8seZ4PUCULdXJAhxBTVU6XlpUOBu7r1OJZdS0qh+Mbo/HsmW1eEAfo8Lw74BogrcR0u6wXrffNzTnXJLByv7XuJ/i/UP+OQjB5Ohgy0gcZCefOFgXCvbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325617; c=relaxed/simple;
	bh=nvooIQw5wf9sEwa0o6IK++YsCkWkUKJUambzwvvpn3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qnnret05FpTiKmHKZ4d/NvtHGIQQiY/O/Bx6bVsENcVwmeKY/Nj/iL9BBXTOT9U2GlVVaClkRlw562Wlu7jZnBVrZnwScCBqlCJajlchtle0haH8SxcDxZeUbYO82yHUJT06s+ff3opgqelMHEHj0DaQUI1USFfbuqT04XMXYfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSZGDSbH; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSZGDSbH"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e16d974030so2384410b6e.1
        for <iwd@lists.linux.dev>; Mon, 07 Oct 2024 11:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728325615; x=1728930415; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pdFx6ym2O/WVquYBEObOAt6/7at4YjaHcsJ6skeJ8Po=;
        b=kSZGDSbHFQSus6lI0l9qBRHwMHh4d8lIrTGB0QPjZd8Qgo5F7xiRp6dC4BZcdk+kdM
         JywUB3W09ddkAcD6/YS7rEbSMKjnXJCFvellWA4YQUXvWF0P9G/FVAaA9uCc/RhSmUeV
         EqK+07rFcVDtOzodcXWU5tTEAAkr17JqofmvkN6HjTiq5N07MgnNhNI9JgFtvEPw089N
         UYbOFx5VTWag5OH1iFPvoclYfF2NBOmMy/GfB9NSoqY+PbC+7AFcE2Ezimmq3JdbD2EF
         fohcfUyTId9EDy8B9FLCxhR1cX6LfupoCROpFW6oAJZl57HyxKjpHnEX88k0IzU2F6Wl
         ZXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325615; x=1728930415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdFx6ym2O/WVquYBEObOAt6/7at4YjaHcsJ6skeJ8Po=;
        b=ucijWPt4piVT7RCN+BcQ4X9FUUeubYHku/1WNnJWDmRGN6X823awmKN2rPoiVmgqis
         9OyREMmyhvP4M+ss6X11Nbk4eMwRAqDqHoIxwBJ7CgjsCAwvsIISqWiq5pJEaPlvTEQG
         EVRpZO9Q6VSFw5KEJihlkUBBPqCPLtIdKg/lPguwwfQylFNU2lGxyjl3ULQQ6QBOskXX
         7Lwp5hWk6fTRSGdG4an1IRSvrOvJKYbSPin2OMpQS5CUPO5noSOZwlyG4B05sExPgQHg
         wCRJnk9rI3+lIaUgXlathJN0tKBTUtFlaRH85HBUaeiLM2aA8cQvBJ57An3cUccv88Iv
         ljCw==
X-Forwarded-Encrypted: i=1; AJvYcCXPI9RlcJEPl0neCw17AOnYJrpKaj1To+tsaoHqdEhO2DkxafG82bezogBtuqKFqdri0i0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxRN9lz1xBkNEK4x1QpHHG5VgPpHxhiTtDu6J088w+I6MKgtGNC
	+J5g5fEmb1O0mqfwGB4igs7V56Pa2CTV5l7xvoftZQb7DafHzwmp
X-Google-Smtp-Source: AGHT+IHx1CUahCx+q0byn77c0Jh4KZ7FNqHlulH/CwEQRt/O8c5ArS21blyWHkkHT8eO2D55dtW2vA==
X-Received: by 2002:a05:6808:11cc:b0:3e0:4260:7912 with SMTP id 5614622812f47-3e3db5d8d1emr295728b6e.19.1728325615338;
        Mon, 07 Oct 2024 11:26:55 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3e3c9013386sm1561479b6e.13.2024.10.07.11.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 11:26:54 -0700 (PDT)
Message-ID: <74c0fb20-e8ca-4d90-9c9c-592d56d0cad9@gmail.com>
Date: Mon, 7 Oct 2024 13:26:53 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] unit: add a test for harmless IE clones
To: Vivek Das Mohapatra <vivek@collabora.com>, iwd@lists.linux.dev
References: <6dbd0686-f054-4c16-bf84-0e383baefdc9@collabora.com>
 <20241005021929.2075817-1-vivek@collabora.com>
 <20241005021929.2075817-2-vivek@collabora.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241005021929.2075817-2-vivek@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vivek,

On 10/4/24 9:19 PM, Vivek Das Mohapatra wrote:
> Test handling of technically illegal but harmless cloned IEs.
> Based on real traffic captured from retail APs.
> 
> As cloned IEs are now allowed the
> 
>    "/IE order/Bad (Duplicate + Out of Order IE) 1"
> 
> test payload has been altered to be more-wrong so it still fails
> verification as expected.
> ---
>   unit/test-mpdu.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 83 insertions(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

