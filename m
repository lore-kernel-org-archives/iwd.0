Content-Type: multipart/mixed; boundary="===============6775828665144554529=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] crypto: fix copy size causing overruns/crashing
Date: Thu, 03 Oct 2019 11:47:30 -0500
Message-ID: <b73f9abb-75ec-20a0-3051-f65abc87d2c3@gmail.com>
In-Reply-To: <d5eab9f2eececb6530ff6d466f6484d28412c836.camel@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6775828665144554529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/3/19 11:44 AM, Prestwood, James wrote:
> Hi Will,
> =

> On Thu, 2019-10-03 at 11:35 -0500, Will Dietz wrote:
>> num_ad is already accounted for in `sizeof(iov)`
>> as iov has size `sizeof(struct iovec) * (num_ad+1)`.
>> ---
>>   src/crypto.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/crypto.c b/src/crypto.c
>> index 632117d..62edd44 100644
>> --- a/src/crypto.c
>> +++ b/src/crypto.c
>> @@ -311,7 +311,7 @@ bool aes_siv_encrypt(const uint8_t *key, size_t
>> key_len, const uint8_t *in,
>>          struct iovec iov[num_ad + 1];
>>          uint8_t v[16];
>>   =

>> -       memcpy(iov, ad, sizeof(iov) * num_ad);
>> +       memcpy(iov, ad, sizeof(struct iovec) * num_ad);
> =

> Good catch! I'm fine with this way, but also fine with simply removing
> * num_ad and leaving sizeof(iov) as is. Lets see what Denis prefers.
> =


Not sure that will work since you define iov to be an array of size =

num_ad + 1?

Regards,
-Denis
--===============6775828665144554529==--

