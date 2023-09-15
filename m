Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCD830CE0
	for <iwd@lists.linux.dev>; Fri, 15 Sep 2023 14:47:15 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6bb07d274feso1238399a34.0
        for <iwd@lists.linux.dev>; Fri, 15 Sep 2023 07:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694789235; x=1695394035; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1B2+JuABCENjeIMh7/wiXzYY4LW23UJna/DoTK/dHd4=;
        b=f1KCiLoOtS4ko0iqp6j72e59w5MZ/cLggx9OGtlXlYVnyVXWSpEyze/p/4cCjGw9eB
         /PGxgjpEuGuOehoKjlImffl5hG75sNnTv494ehMSvLyBZa3zzjIJvmsknfGMU4n0w/NF
         MerjtRCV/RaVBRp2tqJw02BMCc5KcdDf4SwWv872izOF72AOdDvA53/8+smqxg8JQXps
         yIxKJrTTDD3hQ8mFxGMQxns0TiO4y0EYu3lJU27PY66Poh/nODhP7S5g9qv0HH4NoAAE
         yLRU5ifpwfGFMB6Dpv9WpgRsZHXXCb4HlTImFn5YmlO72ydmtdsEzgFkm/GbdBxQlVWW
         YRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694789235; x=1695394035;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1B2+JuABCENjeIMh7/wiXzYY4LW23UJna/DoTK/dHd4=;
        b=B7MBxqf9rHS03dPoPsXeldYXqUlTdKNFSSW8UagVLJw2dZ1kAOrldjM8Dpr8gq5jpP
         +7ZkSwg3gjYNi11fQczSafDIcbce6OxK/j6WRpQm3CTZdJHxZFA8YhvqbU9iYrF0PEPC
         9wzysFwctmzN8gomNigSaYEb5hqtumqD7N8tWJAqgJ62QP25np5WRfnNMApJjB3Brv0J
         lEDOnxXW9+upjRJGvnhWQXhzWIa7gvcTCsesoizdS4PV4uIVyvspKP9nu/C5S7v52hnd
         ubsWjwvOldTMHJBlZLaF0GWnmOsg4I7K/NYdZdBcQwmv6NNLoPn41hZo1NHHkY1XZmF7
         ocSQ==
X-Gm-Message-State: AOJu0Yx0IabVi6VYj3sFaW+oXHhbMigbEUHNQWxVUnkNTjL/kIzedgIm
	uZSUS/Kt85YagEQ3uChvGrr3wHh2CCA=
X-Google-Smtp-Source: AGHT+IFNInub8CFK186nW72Tk070Tii+KcyMnmncS7WI9jaSJBkFiO7VaahfS/8MskNToDNCgKoGpA==
X-Received: by 2002:a05:6830:1db5:b0:6bc:f6d0:87d4 with SMTP id z21-20020a0568301db500b006bcf6d087d4mr1819447oti.29.1694789235211;
        Fri, 15 Sep 2023 07:47:15 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 62-20020a4a1a41000000b00570bc62a8d4sm1840579oof.29.2023.09.15.07.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 07:47:14 -0700 (PDT)
Message-ID: <42efcf9a-6aca-c728-ba9d-fe95a6066900@gmail.com>
Date: Fri, 15 Sep 2023 09:47:13 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Force use of 5GHz band
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>,
 =?UTF-8?Q?Jonas_Gro=c3=9fe_Sundrup?= <cherti-iwd@letopolis.de>,
 iwd@lists.linux.dev
References: <cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
 <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
 <d0b59d7ddf82006b6280e3b6652614d9ece09f7a.camel@grosse-sundrup.com>
 <6aac9366-36fd-474d-882e-1bcc940fb444@gmail.com>
 <ea23c922129d3c18c4affb0f0e4a737b7e2a03e5.camel@grosse-sundrup.com>
 <e74c1a50-b5bf-48eb-a53e-100d9706e7f5@gmail.com>
 <43d47533-a4a3-e3d5-8f17-30467475660a@gmail.com>
 <8629e294-0550-436d-91b3-e0cf1c84f8e7@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <8629e294-0550-436d-91b3-e0cf1c84f8e7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>> Careful about using high factors like this.  Right now the rank is computed 
>> using a double, but truncated to a uint32_t and clamped to USHRT_MAX / 
>> uint16_t.  This works fine, but the FT roaming calculation is a bit more 
>> careless.  Could lead to very funny results.
> 
> I don't think FT uses that ranking factor, but either way yes some huge factor 
> like that shouldn't be needed.
> 

Right, but it uses another factor and truncates to a uint16_t.  So if you have 
USHRT_MAX as rank, multiply then truncate -> fun things happen.

>>
>> We may be better off introducing 2.4GHz factor and suggesting using a 0.0 
>> multiplier to turn bands off.  Or add an explicit setting.
> 
> I actually was thinking this would be nice. We actually don't even run a 2.4ghz 
> network at all so that would reduce extra scanning cycles, even if just a couple 
> seconds. I'll go ahead and add support for 0.0 factors disabling the band, and 
> add a 2.4 factor setting.

Excellent.

Regards,
-Denis
