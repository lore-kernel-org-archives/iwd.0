Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5547810960
	for <iwd@lists.linux.dev>; Mon,  8 May 2023 18:10:38 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-75776686671so86527185a.1
        for <iwd@lists.linux.dev>; Mon, 08 May 2023 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683569437; x=1686161437;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oV9NcuF5xU0IEdY99U55US35sMq1EtmFwmDe1wQEWxA=;
        b=KCCfjy5AKXrz51YMYXJzCkoEtD1aglcgKXky/w1dfa4r4lfnF6Nz9YGcdp8jlapDNk
         b4IzEUsIs8dhGDQhdfkVZFZumncdPtXlGJhhUVjmmFVJEjOLdKBlyC8bfymJiYNgZglx
         T4gk1F8vIi0I1K7KDK9I1Ud6XrrSv6VbN4ETnBDf2pORREba6jJD6t8/fPzkTtEyK37T
         rMiR83AgD1dnfn20zDQugC3b6waxPK97mSQLhYM4IRDjD+4k77nf/x38fE2yh6epGKab
         T8tj96BG+coaKUANxrjnNGHeKu3bGqPlLIYycUOSJIBa439JM5y/R8rdQ4gZnG9Y9Dxh
         0mUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683569437; x=1686161437;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oV9NcuF5xU0IEdY99U55US35sMq1EtmFwmDe1wQEWxA=;
        b=RD2Mumgs5c/k02cKiHSWYLUxSTuuMjatgue8G19ai825qbRFXCI5vG2LTGSlRfd+GT
         o/FaOUjYtmxyBSyqIg2SQ+HI32N8hBY/d4ab92KywpTytjjM6jcHKagYotb1pg3MRt5Y
         +Hry7C7zIRE9EGpsDOc1qB4CfNAfDAbCzBUIlOqvL/Dj2Ehteyj7xJQR7NOTPQqu3oDE
         MOUSIWdqXz6qV2bp/MwOVXKbPExNq8dSq/iIYft4ch15tO21TZyzYMahXB3vAmXZS67u
         KYOiCKHkfuOUfkJj/Q+8tvaMM1+77W4iH1EOveSH+b/8RarF45xze9CgmViEyDa+YOwj
         1JCA==
X-Gm-Message-State: AC+VfDyPUeCSrtvpBkTHEs/EliU9OzStztVHfiQ1uuWe1ELGewpttXZc
	2x+nRv/GF6iwLoro1bB9EytxTgP8GLw=
X-Google-Smtp-Source: ACHHUZ6IiyQ1juIJyI18DFecJVqVx8G7X6NI3JtWXWWC1OvDWvMeZbO3RTGLsG57jNLU0SrknUFXMA==
X-Received: by 2002:a05:6214:c6a:b0:5b3:e172:b63e with SMTP id t10-20020a0562140c6a00b005b3e172b63emr11764793qvj.22.1683569437112;
        Mon, 08 May 2023 11:10:37 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id h17-20020a0cab11000000b00620fe2e8923sm174048qvb.7.2023.05.08.11.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 11:10:36 -0700 (PDT)
Message-ID: <d4f1e66c-197f-d7aa-854a-65831477d7cd@gmail.com>
Date: Mon, 8 May 2023 11:10:34 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] station: fix reentrant FT wiphy radio work insertion
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230501220604.366100-1-prestwoj@gmail.com>
 <7c38d268-7d00-e16c-ff18-de198ba11987@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <7c38d268-7d00-e16c-ff18-de198ba11987@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 5/8/23 10:56 AM, Denis Kenzior wrote:
> Hi James,
> 
> On 5/1/23 17:06, James Prestwood wrote:
>> The failure path for FT was inserting the same work item inside
>> the 'do_work' callback. This caused duplicate work items to be
>> inside the radio work queue, and upon destroy the ID would get
>> zero'ed out. This caused a host of valgrind complaints when this
>> behavior is triggered.
>>
>> This can be seen with slight modifiations to the FT test:
> 
> Typo here, 'modifiations'
> 
>>
>> src/station.c:station_try_next_transition() 9, target 12:00:00:00:00:02
>> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 6
>> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 7
>> src/wiphy.c:wiphy_radio_work_done() Work item 5 done
>> src/wiphy.c:wiphy_radio_work_next() Starting work item 6
>> src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
>> src/ft.c:ft_send_authenticate()
>> src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
>> src/netdev.c:netdev_mlme_notify() MLME notification Frame Wait Cancel(67)
>> src/netdev.c:netdev_mlme_notify() MLME notification Cancel Remain on 
>> Channel(56)
>> src/wiphy.c:wiphy_radio_work_done() Work item 6 done
>>
>> --- Work item 7 is 'station_ft_work_ready()' ---
>>
>> src/wiphy.c:wiphy_radio_work_next() Starting work item 7
>> src/station.c:station_debug_event() StationDebug.Event(ft-roam-failed)
>> src/station.c:station_try_next_transition() 9, target 12:00:00:00:00:03
>> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 8
>>
>> --- Here we insert work item 9, which is a duplicate of 7 ---
>>
> 
> Duplicate in what way? We're going to a different BSS?  Or do you mean 
> that we overwrite station->ft_work because we queue the same work item 
> in the work queue callback?

That we are using the same ft_work structure which already exists in the 
queue. So when it gets cleaned up it modifies both queue items.

> 
>> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 9
>> src/wiphy.c:wiphy_radio_work_next() Starting work item 8
>> src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
>> src/ft.c:ft_send_authenticate()
>> src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
>> src/netdev.c:netdev_mlme_notify() MLME notification Frame Wait Cancel(67)
>> src/netdev.c:netdev_mlme_notify() MLME notification Cancel Remain on 
>> Channel(56)
>> src/wiphy.c:wiphy_radio_work_done() Work item 8 done
>>
>> --- And finally, the duplicated work item starts ---
>>
>> src/wiphy.c:wiphy_radio_work_next() Starting work item 0
>> src/station.c:station_debug_event() StationDebug.Event(ft-roam-failed)
>> src/station.c:station_roam_failed() 9
>> src/station.c:station_roam_trigger_cb() 9
>> ---
>>   src/station.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/station.c b/src/station.c
>> index 0d8f7628..3c6e43ce 100644
>> --- a/src/station.c
>> +++ b/src/station.c
>> @@ -122,6 +122,7 @@ struct station {
>>       uint32_t wiphy_watch;
>> +    struct l_idle *ft_idle;
>>       struct wiphy_radio_work_item ft_work;
>>       bool preparing_roam : 1;
>> @@ -1739,6 +1740,11 @@ static void station_roam_state_clear(struct 
>> station *station)
>>           station->roam_freqs = NULL;
>>       }
>> +    if (station->ft_idle) {
>> +        l_idle_remove(station->ft_idle);
>> +        station->ft_idle = NULL;
>> +    }
>> +
>>       l_queue_clear(station->roam_bss_list, l_free);
>>       ft_clear_authentications(netdev_get_ifindex(station->netdev));
>> @@ -2282,6 +2288,16 @@ static void station_preauthenticate_cb(struct 
>> netdev *netdev,
>>   static void station_transition_start(struct station *station);
>> +static void station_transition_idle(struct l_idle *idle, void 
>> *user_data)
>> +{
>> +    struct station *station = user_data;
>> +
>> +    l_idle_remove(station->ft_idle);
>> +    station->ft_idle = NULL;
>> +
>> +    station_transition_start(station);
>> +}
>> +
>>   static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
>>   {
>>       struct station *station = l_container_of(item, struct station, 
>> ft_work);
>> @@ -2300,7 +2316,8 @@ static bool station_ft_work_ready(struct 
>> wiphy_radio_work_item *item)
>>       if (ret == -ENOENT) {
>>           station_debug_event(station, "ft-roam-failed");
>>   try_next:
>> -        station_transition_start(station);
>> +        station->ft_idle = l_idle_create(station_transition_idle,
>> +                            station, NULL);
>>           return true;
>>       } else if (ret < 0)
>>           goto assoc_failed;
> 
> The patch makes sense to me.  However, I do wonder whether we can take 
> care of this in the wiphy work queue itself?  Maybe by adding 
> wiphy_work_reschedule() or something to that effect?  I would hate to 
> keep doing this l_idle business every time we need to do something similar.

I was thinking that, maybe adding an API would work. I'll see if that is 
possible. Basically the problem I ran into trying to handle it 
automatically was the fact that the work item memory is provided by the 
caller, so when you change one it changes both.

> 
> Regards,
> -Denis
