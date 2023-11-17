Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81111398
	for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoAowH1K"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5844bc378feso1079663eaf.0
        for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 08:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700239910; x=1700844710; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d6LpDtBuBuLRFHILhMsXi7t4MbELrfjsQXs/k5ssHmM=;
        b=DoAowH1KSKzlmPQWqD9LNJwI8V/C4Ly/tMEj1XbsMQQXp+496g9uw9h1vnqdZTcWp1
         yFCy6zKJYPZnuo3+vhBKzKbP2UhQfkQLopMBjbXKXRorg6piuaymksSrezkxSY74o1yt
         gEHcnyYloU4kwFeLj1dwrue2ZHcsjgKVKcq+TV2B0mBHDQYKvfES7JB4FvLULoZSh8um
         CObcp+c5MirP4URJ0URmWNZ3KnUg7EYbBGbL02kizv5xIA7hPr09h+q0pGMfnEJPcGx2
         Bfu/WDjlg+PPvCxj8216oH/HRR1Warz+WxI5IhHAnWlbK4tJufXnqfbsav5CqdfWFkk1
         eiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239910; x=1700844710;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d6LpDtBuBuLRFHILhMsXi7t4MbELrfjsQXs/k5ssHmM=;
        b=fLqq2UzYFUAOL/Z72Q8aBY1fpg0spq0Z+8nb/pTsg+m7i5fIEWIeUsDWoNI6hq/Cj8
         RHQH+iAvTGV551z2eWegpLSZ8TGS+Qh8sw/1rveflNixzkY0bIuQ9tPtNjDeqpnGd2aY
         2gIS3My5WrNiYj9YrVPi3WytVYuw5493cvmxNYzv966fshQt4U4HO648MaItDhSmR4A5
         rt5QNWMXe4w2wGV9iMZsqfIX4KPG2iU7jRk9CMn/S0xcju+Ivc0wfsTgByCmmkeOWnZv
         ZgnMGlQQiNdChbxmzSfAY7v/hdffVfwDiyhegE0vFVsrO3UmvTqqXu53DwJZwvDMQ5mi
         EfIQ==
X-Gm-Message-State: AOJu0YwRuJi/pV5n/g27goxnPN22/jZde//aaoCoKuknEdpKzQ65DkGA
	niZE/EUYDAMk6PcgaNovYhU=
X-Google-Smtp-Source: AGHT+IFUem3u08PVXLhUvE0lRdoTRWtJqVOmKD6EnU32wur0n/2X8UhhgAwwqvi1f9y/AljSYE6gtQ==
X-Received: by 2002:a05:6820:1628:b0:581:ed12:98c6 with SMTP id bb40-20020a056820162800b00581ed1298c6mr179110oob.4.1700239909652;
        Fri, 17 Nov 2023 08:51:49 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 189-20020a4a17c6000000b0058a010374e6sm368879ooe.39.2023.11.17.08.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 08:51:49 -0800 (PST)
Message-ID: <6618b0c0-4c24-421b-a0e6-3c84c38f971f@gmail.com>
Date: Fri, 17 Nov 2023 10:51:48 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dpp: fail early if multicast frame registration is
 unsupported
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231117160016.81253-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231117160016.81253-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/17/23 10:00, James Prestwood wrote:
> This is done already for DPP, do the same for PKEX. Few drivers
> (ath9k upstream, ath10k/11k in progress) support this which is
> unfortunate but since a configurator will not work without this
> capability its best to fail early.
> ---
>   src/dpp.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 

Both applied, thanks.

Regards,
-Denis

