Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F314C5B4
	for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615840; cv=none; b=ci0KpI1MSQUnDmjvCwp3i26EKL1/DXwq2D1VweD8psGoSqQ6LqkSIxM7AiIqfFuZaELyfeTjayMP32csrxJ8fE+3Px2O4dTzcGw41uJmrgE1tkjbuCxrdbW6KIGsE2QCwS4obLoUfuNVLTGLqtqlkDH7AhtuwSdGoO0NCKOb+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615840; c=relaxed/simple;
	bh=TrhHO6iYrrl3gJOVM0Ry00utYDuI+TQQts+cb0xHHxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fBCJRWTSnO/AH8bpHXui+Ozk+0qlr4Cyps04QEtAQy9IvdVROSR8fThMuC2RCLHsT2nCqdxjGWxk+wWe0Xqd79+C927aju+4EXbpNqfq3NHpKPzMcJ3bH15fwkIVeryf4CreKa5kzC4cAsMeMMEzSKAPL4ALt+Fu0Vb7kxW08hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbJ6kISj; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbJ6kISj"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e125818649so908111a34.1
        for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 07:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708615837; x=1709220637; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+oiNDKvnyjfqsfNQMLoZ1o2vhgWF5A1sVDVQZcgC660=;
        b=dbJ6kISjox68NRlCIxG60t2kU/PJPKjtdhwZA7nfazbORdK6qOgc0/5BtpvIe9wAPj
         MtbMsgIIM1SDH0GRNr8X7FG0PZkKh5r16vhnkuk/MZ3ftlLizN1Gzvt4SG571n3bz38z
         WQBBlh+MetT7LH5G7IhHntIZQYPLmmHAGW1hKyOPe8u1uo0xF8CYbzLVt2OmeS4eLa4W
         tgXRSlCRVZLRzIffTkZzfKIlvBF0pCy5WwCmA1WjvaabCfdwlE8gpO+INEpiYOmx97s3
         DqFzwT6/O53fpq3iy/dvD//oaMgrYU4D5tst9evkofKAPgucMTboq7ZopI4PpwCmmlcP
         dW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615837; x=1709220637;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+oiNDKvnyjfqsfNQMLoZ1o2vhgWF5A1sVDVQZcgC660=;
        b=HXAV3hRgW16AzRr0v8uchqZYNm8bSbNeDcCBso7biUWGdZrsclg/ekXdPT/MQdfShd
         gl4qRwSIY/MkgoUH3gWlrYf4AYBr2KKTOf8HDX5hxCkIT5ShkHaepyCAhdotoRFz7yB+
         lw02Bxq7OIiAqX2a9CsrllDEVIc+p/NgO+tvRM9L4frGYEgNYxfN8UxwAPkn7BXMfIXS
         K74dEVHQlI8GXS9VYKgx9eTFDM02k73UJmx0LuWpJR7SIMH1xMHNjbm7K9pJcab2ByVx
         WOzcnJzgIFYQ9zd8uOcVlwnhBZghrC0HGgWkyzXYcf1cmOW3myG8dABQ3yQq3MiH8+iA
         nJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA6JPsOaRgfOlVvidevkidnf/fZrlC+R6iGtbejh328p1MpwonxUsxw4NnHXpJaet3VGP9WeVTmHN3b0aoZGOHnHFo
X-Gm-Message-State: AOJu0YwBMSILc5zyB4t2e0mYy7RJFVrbCE1lnv7foLK2FqCphvVctf0F
	pb3/mB0U1JQL6ubAGYHyysbwzrrMjYIVBiu0d4wm9vkHCK1qD7oT
X-Google-Smtp-Source: AGHT+IHyiC7bdodcyJoFLhIRO3h9g7k4NSHgsFdjZTgimUj/YXY2/jkYKKB8q3yjc0b76btpT659pA==
X-Received: by 2002:a9d:7e96:0:b0:6e4:3e94:d706 with SMTP id m22-20020a9d7e96000000b006e43e94d706mr17213830otp.2.1708615836923;
        Thu, 22 Feb 2024 07:30:36 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id m20-20020a9d6454000000b006e34506c5e5sm2050463otl.57.2024.02.22.07.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:30:36 -0800 (PST)
Message-ID: <86d4712e-8072-45d5-8385-c225ea9309e6@gmail.com>
Date: Thu, 22 Feb 2024 09:30:35 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] auto-t: fix failed_roam_test to pass when run on its
 own
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240214193021.963130-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240214193021.963130-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/14/24 13:30, James Prestwood wrote:
> When running this test with others the hostapd neighbors are already
> grouped which lets the test pass. On its own this does not happen
> and it fails.
> ---
>   autotests/testPSK-roam/failed_roam_test.py | 2 ++
>   1 file changed, 2 insertions(+)
> 

Both applied, thanks.

Regards,
-Denis

