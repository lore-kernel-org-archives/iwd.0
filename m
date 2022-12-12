Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E668A2F58
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 20:55:32 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1443a16b71cso9948460fac.13
        for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 12:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uhzwLGs2p2WAjBP8R3o29OOS9/SZS8mV6NEOA+3P0l0=;
        b=QR87f9u7COwXAlS9LfNtPd7xQe333gNs8Ju9osO8FL7FR9CS3m+JqhG4flkzceC1P6
         t/Wqf6Cx3j9qf+ZILljqRuI17i1tjSuv6xSnou0bFIqrDU2XX1dGs9klVaCnVUWV9Moc
         RfLgGF8KGT1Aahm7NEvheyEK0Xx+7TB84iiRsFNLvIzXLjXBy1e8Eu/f2XjZY4ZIwhCY
         p1zTFH3lo3nx1ng80oqRKLDI6Fsn0cO/XC0RtQD4OPQyQdv+/3hPFX2gSE6pJ3Q0gkKd
         YighLUcOla3Tk9oew9UvDyXMGXB3aFVPgEHJtkseJQG4OtWrYfaHjDDDduCJ4VZ4SKHQ
         nGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uhzwLGs2p2WAjBP8R3o29OOS9/SZS8mV6NEOA+3P0l0=;
        b=yPlJ/gx5XIkx5V4RH+tdP7ZUlf39Yoolm9HfWgKqTxfisICQBYO0yAL2u4cKfhGZoh
         Ca+jZUHKw+SLhii9ijHv7NlqV1yJP6GCjFaER3FG9LPmRJztDTU8z8caq6mfL7/femIQ
         2FQfm+DLLg7vaUc8qXG2YXabtUETBHSVi10CQqls1Jc5HVISAk902ZPFl9YWjXzAz5cb
         Wjkrnk+m+Is+auQq7b3d3d2RNMBs5WEvbkOfzgcJTAZAiAGkOvIeUOBrZik/FJS+G6Ng
         gBNPYbJ8vYMbQOqaNo0zFxHODyjFVctz57/U/QoN92LaTLl62lViewCPwI1X3OXl3IiD
         L8IQ==
X-Gm-Message-State: ANoB5pn9ZcrN3RJwgvc+mpYeVOFeDySbEYKwwaA7MUoZDrvYYa/4vDD8
	6oFbWB0i2iY7GHap1Ad2UhU=
X-Google-Smtp-Source: AA0mqf4RxL1AP63Tq27ZkiABVrbZS9h5qSJqwJjRdlXUF8ki0pr1DwrvDOU4xqZEZ8YDIz68yAmA6A==
X-Received: by 2002:a05:6871:4504:b0:144:fffb:4190 with SMTP id nj4-20020a056871450400b00144fffb4190mr9389670oab.6.1670878531940;
        Mon, 12 Dec 2022 12:55:31 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id j19-20020a056870021300b001446d5702b5sm393457oad.56.2022.12.12.12.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 12:55:31 -0800 (PST)
Message-ID: <fe57337c-0b36-eb53-e03a-8fcd93a89332@gmail.com>
Date: Mon, 12 Dec 2022 14:49:50 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Revert "scan: Don't callback on SCAN_ABORTED"
Content-Language: en-US
To: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <ALSI@bang-olufsen.dk>
Cc: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alvin@pqrs.dk>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <20221212164250.3075444-1-alvin@pqrs.dk>
 <3fb7f5f1-04d8-8631-e7b5-70f27c963ac1@gmail.com>
 <20221212201815.6rma2xhoam2yja4c@bang-olufsen.dk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221212201815.6rma2xhoam2yja4c@bang-olufsen.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alvin,

> I can send v2 with a more explicit title than just revert? See below and
> tell me your preference.
> 

Reverting is fine, or just a new commit on top that calls scan_finished is also 
fine.  Probably the latter is (slightly) more preferable.

>> But...
>>
>>> station scanning state remains true indefinitely if a periodic scan is
>>> aborted, and no further periodic scans can be performed by iwd.
>>
>> I don't see how the station->scanning being always 'true' would prevent us
>> starting a new scan?  station->scanning isn't used anywhere besides
>> reporting over D-Bus?  Maybe I'm missing something?
> 
> No, you are quite right. It was a misunderstanding on my part due to
> nested callbacks (scan callback, and periodic scan callback).
> 
> The reason periodic scans get stuck is because the scan callback,
> scan_periodic_notify(), doesn't get called. So it doesn't rearm the
> periodic scan timer.
> 

Gotcha.  That makes sense now.

> But outwardly - that is, with 'iwctl station wlan0 show' - one can see
> that something is wrong, and that's because the periodic scan callback,
> new_scan_results(), doesn't reset the station scanning state to
> false. As you point out though, this is just cosmetic.
> 

Yep, we should fix that for sure.

Regards,
-Denis
