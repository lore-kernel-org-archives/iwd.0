Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D162F2A
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 22:38:49 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-12c8312131fso5025709fac.4
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 14:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odckNYoFCFTqxZgUchnpFfWKUwsyj9byfisSuub6ZrI=;
        b=p6Am5ZL6fRlQTK444jpIfqAoIVw4mrf3GAC2WJdy+c+9PQi6XKe4QhAgDiDV+iEWf4
         vIutz9ysw9M+vyqstHCdPq70+NvkMD8DgTUSdA7vetpH8VBJoRSKqO4T5/w3uEPK30HW
         yq//tapMAIJT7pFTRaaNnZsp0UliAPzLY7hstAWPQoirficryVI1Zh8/lVF7oGsBaAuc
         zlSpNa3QSm7L05uV9QGd19n7Vb0T3hXHiS4AbnOX8hQgpjGBbMw/CJyMhP0olh8YyFU1
         DUJKQPLZkaIcpB6yI/AVRqCFl/iaoCHeXKOKBH4BWEj2eEcB+UP8mEfbnSVpjdX/bKqe
         vYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odckNYoFCFTqxZgUchnpFfWKUwsyj9byfisSuub6ZrI=;
        b=pv/ZTFqdAJi/cjD6RNE9d1EP86j7Q29dIBb+oRiC9zHk7/EtuW0JVb90gsyYKiPeRF
         CnfRnDc5sE0214qAYnLiJZk5Qs7XtfLOn7T2qm02nEVGg8iO03d2VrJ7qjGJzlkKz45S
         ioCqRFy3sPca1mAHfTP/Ch6Bfb2bJUYXKTDXI992KlGOLSy/fNvmHImFg6E9T10qccrS
         +4IRCl5FwCm8R17c7yDChwk+PghyaogTS0jDBmip7qD9MlLE3cBD2VdR1U5d7FQ9Zc/S
         O/xtnPb0VfAyjgDysRNU6qGBZsEgxU5ETA0LIEeMCxev+3gk0dQSPzlyZ/IPlPm8eaXt
         k74g==
X-Gm-Message-State: ANoB5pltLwOhK34O54wq1aaW0Gb+yLYIODXmTuUeRkr61r4JUA+0V5QH
	rlGhEIK1yoswMiG1K6FyoDo=
X-Google-Smtp-Source: AA0mqf61Rk16EvmIBZSzVOfHW/G1bNl1XB2s89Dj1a8DVH/kHyx7hh+3cYIJRKC4LCD4cog23ZWRmQ==
X-Received: by 2002:a05:6870:6b92:b0:148:9d1:5a0d with SMTP id ms18-20020a0568706b9200b0014809d15a0dmr16419655oab.21.1671230328575;
        Fri, 16 Dec 2022 14:38:48 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d9-20020a056870d28900b00143d4709a38sm1487426oae.55.2022.12.16.14.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 14:38:47 -0800 (PST)
Message-ID: <a149ab7d-d64d-ff8e-128f-91aa818226f9@gmail.com>
Date: Fri, 16 Dec 2022 16:37:51 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/8] band: introduce new method of tracking frequencies
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221216212741.1833286-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221216212741.1833286-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/16/22 15:27, James Prestwood wrote:
> Currently the wiphy object keeps track of supported and disabled
> frequencies as two separate scan_freq_set's. This is very expensive
> and limiting since we have to add more sets in order to track
> additional frequency flags (no-IR, no-HT, no-HE etc).
> 
> Instead we can refactor how frequencies are stored. They will now
> be part of the band object and stored as a list of flag structures
> where each index corresponds to a channel
> ---
>   src/band.c | 2 ++
>   src/band.h | 8 ++++++++
>   2 files changed, 10 insertions(+)

All applied, thanks.

Regards,
-Denis

