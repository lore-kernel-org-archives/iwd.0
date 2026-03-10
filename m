Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6C22EE5FD
	for <iwd@lists.linux.dev>; Tue, 10 Mar 2026 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153190; cv=none; b=W0UJEy+xQtZQlNblK2ulEfZUFevVlgKbgfQLfD1NjUFjRWaJj3x766S4rOH5mweg0Mo0gnvZ5dxDx5DXyQwfstn6Qw1H+0jlOw4fZ3+QSh5atBXk5d63+4munJJyNaaGpofL93NXYhDwR20qNddoeXRjAE8pKEuCu6KcVNHIBtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153190; c=relaxed/simple;
	bh=hbhqupbHeE/0lKH4SfKQbteic1qjbpK1ogt7xgC+Uu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tHNKuxjx9aihdPa5LNpZPyc055SKn6TQCTdij//3kiocpg/VKsc+l+0735Ge0VSB+STjdsEtnwt+N7jt0P4Z8oZPCDFb679Dfnv0rhuQpxJE0fvkj1Rq7sH+Bg033Mqvi3QGIdBR5xI8Ka8YK9Z3rVNE5uQIm0p5iMtXuclY22o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYSTChnF; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYSTChnF"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d75d698ee6so402051a34.3
        for <iwd@lists.linux.dev>; Tue, 10 Mar 2026 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773153188; x=1773757988; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RD4rTMLehghQxI6h2nU+ig8Qr0KRvMyrAsMfw2qArMk=;
        b=BYSTChnFodlmI52YI9IuEpIZ7xv+2vjnC2umeHt+mwKb5cOYzXN+yBgJEcvvz+nbX6
         LkiXiiUKCedF/v6G3/hkLUEUx0v9lFOZGH5o28dJaK6EG0JCDjvouU9iqZmmgo0FIKV4
         uxIdTt/uVB4wsmDGg4nbpEkfkvu5tij/PIgmwgauvzPGpi7p6K2ovEpJRv+yc213yzcN
         eMshyVMWffKTm9UWqEY1jm1YDnIlIz9Alf3CrMzhe20S/YQ2hL/lYAaJKCSfXVWtKEMr
         vs2pDcUZ7tTE939hXdWctsnTe0bTAUiLYXalrZCdmaqNadwGMxVUcnRKFgiMkeWEN5l5
         4PMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153188; x=1773757988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RD4rTMLehghQxI6h2nU+ig8Qr0KRvMyrAsMfw2qArMk=;
        b=DFkxBwoQLpAGXN6EH99PDpR6hl8NpvjzpKqVqVbOaT9NOBFhFZZm9cPktSe5S1rmY0
         h3tr4ZGtele0cYlHPj0qVXX56z3LjJ2z4BQO8YzKiaun9y6tvwWWGiV3/sPZKIMmeiua
         PBZdw96fnz5OSBCchn9sf5XsCXIxGYAc8gqIUkzJ9XaEx7SwkzaFwobZ4Ffh6mfOPe/0
         iGMcC2+6D+UtXcKfkaDQzt/CQTOwt5PSDjvbiQy81mGHqxr+n0z1Ttv8aiNPC81O0e0o
         bB+2F/VY8R0oMf7pQRYcMO+6Fv4SoCH+ge4ewupOJ/mGQonoZSEJ8yFX9/YpaxGqy7Dh
         hmCg==
X-Forwarded-Encrypted: i=1; AJvYcCV4X5YdGkhZbO6HPGVPqdycE/8Hg/Whoe7+huzByHXFBfMWA3ADeJ3TUnhjABcl2rX4XZo=@lists.linux.dev
X-Gm-Message-State: AOJu0YysMZJYnKATsP551w6otlQ/fgOHInaUPQ9vExC/oo4nnA8gSTky
	qZr4PBNrkVgnQIoXUS+e6GgMOVdjCU67Of9iNmPf6NnKdBeo4aHeVKEo
X-Gm-Gg: ATEYQzwX87T3hS+3u/2Xw4vyqXIUNR0bi3GWL/iTNLBXtqztr3L4noHOk6tHpWVFSJM
	SL4MWePU8VoVkgdN/vjgp41h5DdJkWAkkpS4Ltp4Q5gIb9ad4Ltd/TNKdGv1RRY20eJyuLvS6UB
	rN5hhoW4e4zfEstP7QXoPHFcYhRPXxwcW5nxNBljx2Vq/vWGnW/4RT/XWDohNvzbWr2Ci+7G0+l
	svCe9xYOrztTRKVrAK2br10Sdy1sZRkq8iXIVqLjfxsrP9+QGxnnJA1ZmrTQtuLILsuwMkUAqab
	l+GLbSvGMvRaNWoZoOG+D76IWa7YS8K02xVzzenhH+bsA26+BPT1Mwe0JBo9h5o9YvtFDDDbhL0
	7HBT8URBNMpeL7yDmJZbUiyfNPYEyE6y8eNsVwrqEiWzJTxexfh93N6Pok4grz7m6vO9mPPQEu6
	Vs0Ba/XVr5VLzJMm2tXXOJtopuuI0+M8kY
X-Received: by 2002:a05:6830:700b:b0:7d7:5405:193d with SMTP id 46e09a7af769-7d754052448mr3213512a34.24.1773153188072;
        Tue, 10 Mar 2026 07:33:08 -0700 (PDT)
Received: from [172.16.49.130] ([70.112.199.191])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7d74885b5a4sm4733530a34.23.2026.03.10.07.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:33:07 -0700 (PDT)
Message-ID: <67cd5fe8-2d24-47fe-9d51-84ea312bdf87@gmail.com>
Date: Tue, 10 Mar 2026 09:33:06 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] station: check return of handshake_state_set_pmksa
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20260309165746.2073055-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20260309165746.2073055-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 3/9/26 11:57 AM, James Prestwood wrote:
> If this fails num_pmkids and pmkids would get set, but to an
> uninitialized buffer. This would then fail to build the handshake
> object later when copying the PMKID.
> ---
>   src/station.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 

All applied, thanks.

Regards,
-Denis
