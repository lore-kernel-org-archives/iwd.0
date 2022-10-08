Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB27E
	for <iwd@lists.linux.dev>; Sat,  8 Oct 2022 03:40:23 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id w196so1206766oiw.8
        for <iwd@lists.linux.dev>; Fri, 07 Oct 2022 20:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xuOeRfzMfjKnLRpFScyECkURZfFhKgtEI7T0XV7LYz8=;
        b=fpW8olAXwY3+gi5ZCuXr3owISEmohAFQYRrEUfq9Y+GnqiYbBAb/9N5SY412+0s1Oq
         L7+fAUVb5UrCV+K+NHiZewsMIwBCZVxVbMzF1j3P2EYrVWgJ6xcZzXvaNLMcr5P5jhXx
         o792J7g6l6fT+jcZJETmk71ilBwkHoZ43OBviPkhiYeGg9iaI+eJbIZd6JFssLwJAjvz
         bue6xEXuzOWL+snyqHmUWzdqf+5oXqY/WoGOGmQNmoDwEnG5sPEVoGwsUuvySaZiqSS9
         Z3jCNSpHPTCrHTttALZrh+BOt45WwnzTGNBpKzt1g2nl888R3lVCgzFOxUMRjjqKwjUz
         LhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xuOeRfzMfjKnLRpFScyECkURZfFhKgtEI7T0XV7LYz8=;
        b=ThtnwAjZCUZDMCuGP9FdtsIkMWOfIKekiACkQy7VoqW890+iq46Tn6FVq33G7h08Dp
         RFP1+z4rR5p4qKH2z6eJPywQURPitDNJRAY+/Fgnc4LVK2D5c9UunDn/beuB4ZcKeoim
         N/ACMvUDb0/XmwoGr4V9UjHVJxaYtXJu05vhSfD3FALWjDLcwUqSHi5LdfMh3YBiClzZ
         Io4+BKkZH6oVJM4m39SQvctrFrHAkNENfLcfGkvLOJvC/j24uvCMxoco+o/JWs8Ja5nj
         y4QLavgzZWDMq6oTyMImZ8Ygfdo39WJPedxetV8uSuMt0+97WmIXz0TzOZsH4zEZXfFl
         XDNA==
X-Gm-Message-State: ACrzQf39g3ObkozpkkhXeK3NuUGoFXtYj1aJkDl0VfBT6+0vNlBjL4vw
	ihb0JOeMSW7RbxJSV+gS3l84aSzgb8k=
X-Google-Smtp-Source: AMsMyM6jVPSswiZw9SPGIokOiCDVqQVytC31UFA9CdX6dzfwsTgr3VlMCJrDic6P0yPiPiZCs7Rubw==
X-Received: by 2002:a05:6808:d52:b0:350:9a6a:3c82 with SMTP id w18-20020a0568080d5200b003509a6a3c82mr4091272oik.197.1665200423075;
        Fri, 07 Oct 2022 20:40:23 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y9-20020a056870418900b0010e73e252b8sm2275044oac.6.2022.10.07.20.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 20:40:22 -0700 (PDT)
Message-ID: <f4d3f7da-85b8-3913-852f-468290c7af66@gmail.com>
Date: Fri, 7 Oct 2022 22:40:21 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] client: better support utf-8 for table rows
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221007195937.8842-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221007195937.8842-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/7/22 14:59, James Prestwood wrote:
> The utf-8 bytes were being counted as normal ascii so the
> width maximum was not being increased to include
> non-printable bytes like it is for color escape sequences.
> This lead to the row not printing enough characters which
> effected the text further down the line.
> 
> Fix this by increasing 'max' when non-codepoint utf-8
> characters are found.
> ---
>   client/display.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

