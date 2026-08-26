/*
# Create quote requests inbox

1. New Tables
- `quote_requests`
- `id` (uuid, primary key)
- `name` (text, visitor name)
- `phone` (text, contact number)
- `email` (text, contact email)
- `vehicle` (text, vehicle description)
- `service` (text, selected service)
- `message` (text, optional project notes)
- `created_at` (timestamp, submission time)

2. Security
- Enable row-level security on `quote_requests`.
- Allow unauthenticated and authenticated visitors to submit quote requests.
- Do not expose the inbox for public reading or editing.

3. Important Notes
- This is a single-business intake form with no sign-in flow.
- Form submissions are write-only from the public website.
*/

CREATE TABLE IF NOT EXISTS public.quote_requests (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  phone text NOT NULL,
  email text NOT NULL,
  vehicle text NOT NULL,
  service text NOT NULL,
  message text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.quote_requests ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Public can submit quote requests" ON public.quote_requests;
CREATE POLICY "Public can submit quote requests"
  ON public.quote_requests
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

DROP POLICY IF EXISTS "Public cannot read quote requests" ON public.quote_requests;
CREATE POLICY "Public cannot read quote requests"
  ON public.quote_requests
  FOR SELECT
  TO anon, authenticated
  USING (false);

DROP POLICY IF EXISTS "Public cannot update quote requests" ON public.quote_requests;
CREATE POLICY "Public cannot update quote requests"
  ON public.quote_requests
  FOR UPDATE
  TO anon, authenticated
  USING (false)
  WITH CHECK (false);

DROP POLICY IF EXISTS "Public cannot delete quote requests" ON public.quote_requests;
CREATE POLICY "Public cannot delete quote requests"
  ON public.quote_requests
  FOR DELETE
  TO anon, authenticated
  USING (false);